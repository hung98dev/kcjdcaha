// Import các package và module cần thiết
import 'package:flutter_bloc/flutter_bloc.dart'; // Package quản lý state với BLoC pattern
import 'package:freezed_annotation/freezed_annotation.dart'; // Package tạo immutable class
import 'package:injectable/injectable.dart'; // Package hỗ trợ dependency injection
import 'package:sync_ops/features/auth/domain/entities/user.dart'; // Entity User
import 'package:sync_ops/features/auth/domain/usecases/get_current_user_usecase.dart'; // UseCase lấy thông tin user hiện tại
import 'package:sync_ops/features/auth/domain/usecases/is_logged_in_usecase.dart'; // UseCase kiểm tra trạng thái đăng nhập
import 'package:sync_ops/features/auth/domain/usecases/is_token_valid_usecase.dart'; // UseCase kiểm tra tính hợp lệ của token
import 'package:sync_ops/features/auth/domain/usecases/login_usecase.dart'; // UseCase xử lý đăng nhập
import 'package:sync_ops/features/auth/domain/usecases/logout_usecase.dart'; // UseCase xử lý đăng xuất
import 'package:sync_ops/features/auth/domain/usecases/refresh_token_usecase.dart'; // UseCase làm mới token
import 'package:sync_ops/features/auth/domain/usecases/register_usecase.dart'; // UseCase xử lý đăng ký

// File được tạo tự động bởi freezed
part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

// BLoC xử lý các sự kiện và trạng thái liên quan đến xác thực
@injectable // Đánh dấu class có thể được inject bởi GetIt
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Các UseCase cần thiết cho việc xử lý xác thực
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;
  final IsTokenValidUseCase _isTokenValidUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;

  // Constructor nhận các UseCase thông qua dependency injection
  AuthBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
    this._isLoggedInUseCase,
    this._isTokenValidUseCase,
    this._refreshTokenUseCase,
  ) : super(const AuthState.initial()) {
    // Khởi tạo với trạng thái ban đầu
    // Đăng ký các handler cho các sự kiện
    on<_CheckAuthStatus>(_onCheckAuthStatus); // Kiểm tra trạng thái xác thực
    on<_LoginRequested>(_onLoginRequested); // Xử lý yêu cầu đăng nhập
    on<_RegisterRequested>(_onRegisterRequested); // Xử lý yêu cầu đăng ký
    on<_LogoutRequested>(_onLogoutRequested); // Xử lý yêu cầu đăng xuất
    on<_RefreshTokenRequested>(
      _onRefreshTokenRequested,
    ); // Xử lý yêu cầu làm mới token
  }

  Future<void> _onCheckAuthStatus(
    _CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final isTokenValid = await _isTokenValidUseCase();

    if (isTokenValid) {
      // Nếu token hợp lệ, lấy thông tin người dùng hiện tại
      final userResult = await _getCurrentUserUseCase();
      userResult.fold(
        (failure) => emit(const AuthState.unauthenticated()),
        (user) => emit(AuthState.authenticated(user!)),
      );
    } else {
      // Nếu token không hợp lệ, thử làm mới token
      final refreshResult = await _refreshTokenUseCase();
      refreshResult.fold(
        (failure) {
          // Nếu làm mới token thất bại, chuyển về trạng thái chưa xác thực
          emit(const AuthState.unauthenticated());
        },
        (user) {
          // Nếu làm mới token thành công, chuyển về trạng thái đã xác thực
          emit(AuthState.authenticated(user));
        },
      );
    }
  }

  Future<void> _onLoginRequested(
    _LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _loginUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthState.error(failure.toString())),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onRegisterRequested(
    _RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _registerUseCase(
      event.email,
      event.password,
      event.fullName,
    );
    result.fold(
      (failure) => emit(AuthState.error(failure.toString())),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _logoutUseCase();
    result.fold(
      (failure) => emit(AuthState.error(failure.toString())),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _onRefreshTokenRequested(
    _RefreshTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _refreshTokenUseCase();
    result.fold(
      (failure) => emit(const AuthState.unauthenticated()),
      (user) => emit(AuthState.authenticated(user)),
    );
  }
}

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

// Import các package cần thiết
import 'package:get_it/get_it.dart' as _i174; // Package GetIt để quản lý dependency injection
import 'package:http/http.dart' as _i519; // Package http để thực hiện các HTTP request
import 'package:injectable/injectable.dart' as _i526; // Package injectable để tự động tạo dependency injection
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart' as _i161; // Package kiểm tra kết nối internet
import 'package:shared_preferences/shared_preferences.dart' as _i460; // Package lưu trữ local data

// Import các module trong ứng dụng
import '../../core/network/network_info.dart' as _i892; // Module kiểm tra trạng thái mạng
import '../../features/auth/data/datasources/auth_local_data_source.dart' as _i852; // Data source local cho authentication
import '../../features/auth/data/datasources/auth_remote_data_source.dart' as _i107; // Data source remote cho authentication
import '../../features/auth/data/repositories/auth_repository_impl.dart' as _i153; // Implementation của auth repository
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787; // Interface của auth repository
import '../../features/auth/domain/usecases/get_current_user_usecase.dart' as _i17; // Use case lấy thông tin user hiện tại
import '../../features/auth/domain/usecases/is_logged_in_usecase.dart' as _i48; // Use case kiểm tra trạng thái đăng nhập
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188; // Use case xử lý đăng nhập
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48; // Use case xử lý đăng xuất
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941; // Use case xử lý đăng ký
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797; // Bloc quản lý state cho authentication
import '../routes/app_router.dart' as _i629; // Router quản lý navigation

// Hàm khởi tạo và đăng ký các dependencies vào GetIt container
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);

  // Đăng ký AuthRemoteDataSource - xử lý các request authentication với server
  gh.factory<_i107.AuthRemoteDataSource>(
    () => _i107.AuthRemoteDataSourceImpl(client: gh<_i519.Client>()),
  );

  // Đăng ký NetworkInfo - kiểm tra trạng thái kết nối mạng
  gh.factory<_i892.NetworkInfo>(
    () => _i892.NetworkInfoImpl(gh<_i161.InternetConnection>()),
  );

  // Đăng ký AuthLocalDataSource - xử lý lưu trữ dữ liệu authentication local
  gh.factory<_i852.AuthLocalDataSource>(
    () => _i852.AuthLocalDataSourceImpl(
      sharedPreferences: gh<_i460.SharedPreferences>(),
    ),
  );

  // Đăng ký AuthRepository - quản lý business logic cho authentication
  gh.factory<_i787.AuthRepository>(
    () => _i153.AuthRepositoryImpl(
      remoteDataSource: gh<_i107.AuthRemoteDataSource>(),
      localDataSource: gh<_i852.AuthLocalDataSource>(),
      networkInfo: gh<_i892.NetworkInfo>(),
    ),
  );

  // Đăng ký các use cases cho authentication
  gh.factory<_i17.GetCurrentUserUseCase>(
    () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
  );

  gh.factory<_i48.IsLoggedInUseCase>(
    () => _i48.IsLoggedInUseCase(gh<_i787.AuthRepository>()),
  );

  gh.factory<_i188.LoginUseCase>(
    () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
  );

  gh.factory<_i48.LogoutUseCase>(
    () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
  );

  gh.factory<_i941.RegisterUseCase>(
    () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
  );

  // Đăng ký AuthBloc - quản lý state cho authentication
  gh.factory<_i797.AuthBloc>(
    () => _i797.AuthBloc(
      gh<_i188.LoginUseCase>(),
      gh<_i941.RegisterUseCase>(),
      gh<_i48.LogoutUseCase>(),
      gh<_i17.GetCurrentUserUseCase>(),
      gh<_i48.IsLoggedInUseCase>(),
    ),
  );

  // Đăng ký AppRouter - quản lý navigation dựa trên trạng thái đăng nhập
  gh.factory<_i629.AppRouter>(
    () => _i629.AppRouter(gh<_i48.IsLoggedInUseCase>()),
  );

  return getIt;
}

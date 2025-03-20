import 'package:dartz/dartz.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// Đăng nhập với email và mật khẩu
  Future<Either<Failure, User>> login(String email, String password);

  /// Đăng ký tài khoản mới
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String fullName,
  );

  /// Đăng xuất
  Future<Either<Failure, void>> logout();

  /// Lấy thông tin người dùng hiện tại
  Future<Either<Failure, User?>> getCurrentUser();

  /// Kiểm tra trạng thái đăng nhập
  Future<bool> isLoggedIn();

  /// Quên mật khẩu
  Future<Either<Failure, void>> forgotPassword(String email);

  /// Đổi mật khẩu
  Future<Either<Failure, void>> changePassword(
    String oldPassword,
    String newPassword,
  );
}

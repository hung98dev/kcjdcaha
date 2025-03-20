// Import thư viện equatable để so sánh các object
import 'package:equatable/equatable.dart';

// Lớp trừu tượng cơ sở cho tất cả các lỗi, kế thừa từ Equatable
abstract class Failure extends Equatable {
  // Override phương thức props từ Equatable, trả về list rỗng
  @override
  List<Object> get props => [];
}

// Các lớp lỗi cơ bản
class ServerFailure extends Failure {}      // Lỗi từ server
class CacheFailure extends Failure {}       // Lỗi cache
class NetworkFailure extends Failure {}     // Lỗi mạng

// Lớp cơ sở cho các lỗi xác thực
class AuthFailure extends Failure {
  final String message;                     // Thuộc tính lưu thông báo lỗi
  AuthFailure(this.message);               // Constructor nhận thông báo lỗi

  @override
  List<Object> get props => [message];     // Override props để so sánh message
}

// Các lớp lỗi xác thực cụ thể
class InvalidCredentialsFailure extends AuthFailure {
  // Lỗi thông tin đăng nhập không hợp lệ
  InvalidCredentialsFailure() : super('Email hoặc mật khẩu không đúng');
}

class EmailAlreadyInUseFailure extends AuthFailure {
  // Lỗi email đã tồn tại
  EmailAlreadyInUseFailure() : super('Email đã được sử dụng');
}

class WeakPasswordFailure extends AuthFailure {
  // Lỗi mật khẩu yếu
  WeakPasswordFailure() : super('Mật khẩu quá yếu');
}

class UserNotFoundFailure extends AuthFailure {
  // Lỗi không tìm thấy người dùng
  UserNotFoundFailure() : super('Không tìm thấy người dùng');
}

class UserDisabledFailure extends AuthFailure {
  // Lỗi tài khoản bị vô hiệu hóa
  UserDisabledFailure() : super('Tài khoản đã bị vô hiệu hóa');
}

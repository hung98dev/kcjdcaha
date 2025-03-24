// Định nghĩa các exception được sử dụng trong ứng dụng

// Exception cơ bản cho lỗi từ server
class ServerException implements Exception {}

// Exception cho các lỗi liên quan đến bộ nhớ cache
class CacheException implements Exception {}

// Exception cho các lỗi về kết nối mạng
class NetworkException implements Exception {}

// Lớp cơ sở cho các exception liên quan đến xác thực
class AuthException implements Exception {
  final String message; // Thuộc tính lưu thông báo lỗi
  AuthException(this.message); // Constructor nhận thông báo lỗi
}

// Exception cho trường hợp thông tin đăng nhập không hợp lệ
class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException() : super('Email hoặc mật khẩu không đúng');
}

// Exception cho trường hợp email đã được đăng ký trước đó
class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException() : super('Email đã được sử dụng');
}

// Exception cho trường hợp không tìm thấy người dùng trong hệ thống
class UserNotFoundException extends AuthException {
  UserNotFoundException() : super('Không tìm thấy người dùng');
}

// Exception cho trường hợp tài khoản người dùng đã bị khóa
class UserDisabledException extends AuthException {
  UserDisabledException() : super('Tài khoản đã bị vô hiệu hóa');
}

// Exception cho trường hợp không tìm thấy dữ liệu
class NotFoundException implements Exception {}

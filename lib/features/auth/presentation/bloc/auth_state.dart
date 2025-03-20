// File này là một phần của auth_bloc.dart
part of 'auth_bloc.dart';

// Định nghĩa các trạng thái có thể có của quá trình xác thực
@freezed
sealed class AuthState with _$AuthState {
  // Trạng thái ban đầu khi ứng dụng khởi động
  const factory AuthState.initial() = Initial;

  // Trạng thái đang tải, ví dụ: đang xử lý đăng nhập/đăng ký
  const factory AuthState.loading() = Loading;

  // Trạng thái đã xác thực thành công, lưu thông tin người dùng
  const factory AuthState.authenticated(User user) = Authenticated;

  // Trạng thái chưa xác thực hoặc đã đăng xuất
  const factory AuthState.unauthenticated() = Unauthenticated;

  // Trạng thái lỗi, kèm theo thông báo lỗi
  const factory AuthState.error(String message) = Error;
}

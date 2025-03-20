// Lớp chứa các hằng số liên quan đến API
class ApiConstants {
  // URL cơ sở của API
  static const String baseUrl = 'https://api.syncops.com/api/v1';

  // Các endpoint liên quan đến xác thực
  static const String login = '/auth/login';           // Endpoint đăng nhập
  static const String register = '/auth/register';     // Endpoint đăng ký
  static const String logout = '/auth/logout';         // Endpoint đăng xuất
  static const String forgotPassword = '/auth/forgot-password';    // Endpoint quên mật khẩu
  static const String changePassword = '/auth/change-password';    // Endpoint đổi mật khẩu

  // Các giá trị timeout cho kết nối API
  static const int connectionTimeout = 30000; // Thời gian chờ kết nối tối đa: 30 giây
  static const int receiveTimeout = 30000;    // Thời gian chờ nhận phản hồi tối đa: 30 giây
}

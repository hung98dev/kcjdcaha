/// Lớp tiện ích cung cấp các phương thức xác thực dữ liệu đầu vào
class ValidationUtils {
  /// Xác thực email
  /// Trả về null nếu hợp lệ, ngược lại trả về thông báo lỗi
  static String? validateEmail(
    String? value,
    String errorEmpty,
    String errorInvalid,
  ) {
    if (value == null || value.isEmpty) {
      return errorEmpty;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return errorInvalid;
    }
    return null;
  }

  /// Xác thực mật khẩu
  /// Trả về null nếu hợp lệ, ngược lại trả về thông báo lỗi
  static String? validatePassword(
    String? value,
    String errorEmpty, [
    String? errorTooShort,
    int minLength = 6,
  ]) {
    if (value == null || value.isEmpty) {
      return errorEmpty;
    }
    if (errorTooShort != null && value.length < minLength) {
      return errorTooShort;
    }
    return null;
  }

  /// Xác thực xác nhận mật khẩu
  /// Trả về null nếu hợp lệ, ngược lại trả về thông báo lỗi
  static String? validateConfirmPassword(
    String? value,
    String password,
    String errorEmpty,
    String errorNotMatch,
  ) {
    if (value == null || value.isEmpty) {
      return errorEmpty;
    }
    if (value != password) {
      return errorNotMatch;
    }
    return null;
  }

  /// Xác thực trường bắt buộc
  /// Trả về null nếu hợp lệ, ngược lại trả về thông báo lỗi
  static String? validateRequired(String? value, String errorEmpty) {
    if (value == null || value.isEmpty) {
      return errorEmpty;
    }
    return null;
  }
}

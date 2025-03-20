// Import package freezed để tạo immutable class
import 'package:freezed_annotation/freezed_annotation.dart';

// File được tạo tự động bởi freezed
part 'user.freezed.dart';

// Định nghĩa entity User với freezed
@freezed
abstract class User with _$User {
  // Factory constructor để tạo instance của User
  const factory User({
    required String id, // ID duy nhất của user
    required String email, // Email của user, dùng để đăng nhập
    required String fullName, // Tên đầy đủ của user
    String? photoUrl, // URL ảnh đại diện, có thể null
    required List<String> roles, // Danh sách các vai trò của user
    required bool isActive, // Trạng thái hoạt động của user
    required DateTime createdAt, // Thời điểm tạo tài khoản
    DateTime? lastLogin, // Thời điểm đăng nhập cuối cùng, có thể null
  }) = _User;
}

// Import package freezed để tạo immutable class
import 'package:freezed_annotation/freezed_annotation.dart';

// File được tạo tự động bởi freezed
part 'role.freezed.dart';

// Định nghĩa entity Role với freezed
@freezed
abstract class Role with _$Role {
  // Private constructor để có thể thêm method tùy chỉnh
  const Role._();

  // Factory constructor để tạo instance của Role
  const factory Role({
    required String id, // ID duy nhất của vai trò
    required String name, // Tên vai trò (ví dụ: Admin, User)
    required String description, // Mô tả chi tiết về vai trò
    required List<String> permissions, // Danh sách các quyền của vai trò
  }) = _Role;
}

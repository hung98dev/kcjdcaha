import 'package:sync_ops/features/auth/domain/entities/default_roles.dart';
import 'package:sync_ops/features/auth/domain/entities/user.dart';

/// Helper class để kiểm tra quyền của người dùng
class PermissionHelper {
  /// Kiểm tra xem người dùng có quyền cụ thể hay không
  static bool hasPermission(User user, String permission) {
    // Nếu người dùng không active, không có quyền gì
    if (!user.isActive) return false;

    // Kiểm tra từng role của user
    for (final role in user.roles) {
      // Nếu user có role admin, luôn có tất cả quyền
      if (role == DefaultRoles.admin) return true;

      // Kiểm tra quyền dựa trên role
      if (role == DefaultRoles.manager &&
          DefaultRoles.managerPermissions.contains(permission)) {
        return true;
      }

      if (role == DefaultRoles.staff &&
          DefaultRoles.staffPermissions.contains(permission)) {
        return true;
      }
    }

    return false;
  }

  /// Kiểm tra xem người dùng có bất kỳ quyền nào trong danh sách hay không
  static bool hasAnyPermission(User user, List<String> permissions) {
    for (final permission in permissions) {
      if (hasPermission(user, permission)) {
        return true;
      }
    }
    return false;
  }

  /// Kiểm tra xem người dùng có tất cả quyền trong danh sách hay không
  static bool hasAllPermissions(User user, List<String> permissions) {
    for (final permission in permissions) {
      if (!hasPermission(user, permission)) {
        return false;
      }
    }
    return true;
  }

  /// Lấy danh sách quyền dựa trên role
  static List<String> getPermissionsByRole(String role) {
    switch (role) {
      case DefaultRoles.admin:
        return DefaultRoles.adminPermissions;
      case DefaultRoles.manager:
        return DefaultRoles.managerPermissions;
      case DefaultRoles.staff:
        return DefaultRoles.staffPermissions;
      default:
        return [];
    }
  }
}

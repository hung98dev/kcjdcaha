import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_ops/features/auth/domain/entities/user.dart';
import 'package:sync_ops/features/auth/domain/helpers/permission_helper.dart';
import 'package:sync_ops/features/auth/presentation/bloc/auth_bloc.dart';

/// Widget để kiểm tra quyền và hiển thị nội dung tương ứng
class PermissionChecker extends StatelessWidget {
  /// Widget con sẽ được hiển thị nếu người dùng có quyền
  final Widget child;

  /// Quyền cần kiểm tra
  final String permission;

  /// Widget sẽ hiển thị nếu người dùng không có quyền
  final Widget? fallback;

  /// Nếu true, sẽ kiểm tra xem người dùng có bất kỳ quyền nào trong danh sách
  final bool anyPermission;

  /// Danh sách quyền cần kiểm tra (chỉ sử dụng khi anyPermission = true hoặc allPermissions = true)
  final List<String>? permissions;

  /// Nếu true, sẽ kiểm tra xem người dùng có tất cả quyền trong danh sách
  final bool allPermissions;

  const PermissionChecker({
    super.key,
    required this.child,
    this.permission = '',
    this.fallback,
    this.anyPermission = false,
    this.allPermissions = false,
    this.permissions,
  }) : assert(
         (permission != '' && !anyPermission && !allPermissions) ||
             ((anyPermission || allPermissions) && permissions != null),
         'Phải cung cấp một permission hoặc danh sách permissions với anyPermission/allPermissions',
       );

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, User?>(
      selector: (state) {
        return switch (state) {
          Authenticated(user: final user) => user,
          _ => null,
        };
      },
      builder: (context, user) {
        if (user == null) {
          return fallback ?? const SizedBox.shrink();
        }

        bool hasPermission = false;

        if (anyPermission && permissions != null) {
          hasPermission = PermissionHelper.hasAnyPermission(user, permissions!);
        } else if (allPermissions && permissions != null) {
          hasPermission = PermissionHelper.hasAllPermissions(
            user,
            permissions!,
          );
        } else {
          hasPermission = PermissionHelper.hasPermission(user, permission);
        }

        if (hasPermission) {
          return child;
        } else {
          return fallback ?? const SizedBox.shrink();
        }
      },
    );
  }
}

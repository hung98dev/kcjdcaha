// Import các package cần thiết từ Flutter và các module tự định nghĩa
import 'package:flutter/material.dart';
import 'package:sync_ops/features/auth/domain/entities/permission.dart';
import 'package:sync_ops/features/auth/presentation/widgets/permission_checker.dart';

// Widget FeatureCard hiển thị một card chức năng với icon, tiêu đề và phụ đề
class FeatureCard extends StatelessWidget {
  // Icon hiển thị trên card
  final IconData icon;
  // Tiêu đề chính của card
  final String title;
  // Phụ đề mô tả chức năng
  final String subtitle;
  // Callback khi người dùng nhấn vào card
  final VoidCallback? onTap;
  // Danh sách các quyền cần thiết để truy cập chức năng
  final List<String> requiredPermissions;
  // Xác định xem người dùng cần có tất cả quyền hay chỉ cần một trong các quyền
  final bool requireAnyPermission;

  // Constructor với các tham số bắt buộc và tùy chọn
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.requiredPermissions = const [], // Mặc định không yêu cầu quyền
    this.requireAnyPermission = true, // Mặc định chỉ cần một quyền là đủ
  });

  @override
  Widget build(BuildContext context) {
    // Tạo widget card cơ bản với giao diện và tương tác
    final card = Card(
      elevation: 4, // Độ nổi của card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), // Bo góc card
      child: InkWell(
        onTap: onTap, // Xử lý sự kiện khi nhấn
        borderRadius: BorderRadius.circular(16), // Bo góc hiệu ứng ripple
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.width * 0.40,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: MediaQuery.of(context).size.width * 0.12,
                color: Colors.blue,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.012),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.012),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // Kiểm tra quyền truy cập
    if (requiredPermissions.isEmpty) {
      return card; // Nếu không yêu cầu quyền, trả về card trực tiếp
    }

    // Bọc card trong PermissionChecker để kiểm tra quyền
    return PermissionChecker(
      permissions: requiredPermissions, // Danh sách quyền cần kiểm tra
      anyPermission: requireAnyPermission, // Kiểm tra một hoặc tất cả quyền
      fallback: const SizedBox.shrink(), // Ẩn card nếu không có quyền
      child: card, // Widget card cần kiểm tra quyền
    );
  }

  // Các factory constructor cho từng module trong hệ thống
  // Constructor cho module CRM (Quản lý khách hàng)
  factory FeatureCard.crm({VoidCallback? onTap, bool viewOnly = false}) {
    return FeatureCard(
      icon: Icons.people_outline,
      title: 'CRM',
      subtitle: 'Quản lý khách hàng',
      onTap: onTap,
      requiredPermissions:
          viewOnly
              ? [Permissions.viewCustomers, Permissions.viewLeads]
              : [
                Permissions.viewCustomers,
                Permissions.viewLeads,
                Permissions.manageCustomers,
                Permissions.manageLeads,
              ],
      requireAnyPermission: true,
    );
  }

  // Constructor cho module WMS (Quản lý kho hàng)
  factory FeatureCard.wms({VoidCallback? onTap, bool viewOnly = false}) {
    return FeatureCard(
      icon: Icons.inventory_2_outlined,
      title: 'WMS',
      subtitle: 'Quản lý kho hàng',
      onTap: onTap,
      requiredPermissions:
          viewOnly
              ? [Permissions.viewInventory, Permissions.viewWarehouses]
              : [
                Permissions.viewInventory,
                Permissions.viewWarehouses,
                Permissions.manageInventory,
                Permissions.manageWarehouses,
              ],
      requireAnyPermission: true,
    );
  }

  // Constructor cho module MES (Quản lý sản xuất)
  factory FeatureCard.mes({VoidCallback? onTap, bool viewOnly = false}) {
    return FeatureCard(
      icon: Icons.precision_manufacturing_outlined,
      title: 'MES',
      subtitle: 'Quản lý sản xuất',
      onTap: onTap,
      requiredPermissions:
          viewOnly
              ? [Permissions.viewProduction, Permissions.viewQuality]
              : [
                Permissions.viewProduction,
                Permissions.viewQuality,
                Permissions.manageProduction,
                Permissions.manageQuality,
              ],
      requireAnyPermission: true,
    );
  }

  // Constructor cho module ERP (Quản lý doanh nghiệp)
  factory FeatureCard.erp({VoidCallback? onTap, bool viewOnly = false}) {
    return FeatureCard(
      icon: Icons.business_outlined,
      title: 'ERP',
      subtitle: 'Quản lý doanh nghiệp',
      onTap: onTap,
      requiredPermissions:
          viewOnly
              ? [Permissions.viewFinance, Permissions.viewHR]
              : [
                Permissions.viewFinance,
                Permissions.viewHR,
                Permissions.manageFinance,
                Permissions.manageHR,
              ],
      requireAnyPermission: true,
    );
  }

  // Constructor cho module Admin (Quản trị hệ thống)
  factory FeatureCard.admin({VoidCallback? onTap, bool viewOnly = false}) {
    return FeatureCard(
      icon: Icons.admin_panel_settings_outlined,
      title: 'Admin',
      subtitle: 'Quản trị hệ thống',
      onTap: onTap,
      requiredPermissions:
          viewOnly
              ? [
                Permissions.viewUsers,
                Permissions.viewRoles,
                Permissions.viewSettings,
              ]
              : [
                Permissions.viewUsers,
                Permissions.viewRoles,
                Permissions.viewSettings,
                Permissions.manageUsers,
                Permissions.manageRoles,
                Permissions.manageSettings,
              ],
      requireAnyPermission: true,
    );
  }

  // Constructor cho module Admin (Quản trị hệ thống)
  factory FeatureCard.acount({VoidCallback? onTap, bool viewOnly = false}) {
    return FeatureCard(
      icon: Icons.person_2_outlined,
      title: 'Account',
      subtitle: 'Tài khoản người dùng',
      onTap: onTap,
      requiredPermissions: [],
      requireAnyPermission: true,
    );
  }

  // Constructor cho module HRM (Quản lý nhân sự)
  factory FeatureCard.hrm({VoidCallback? onTap, bool viewOnly = false}) {
    return FeatureCard(
      icon: Icons.people_alt_outlined,
      title: 'HRM',
      subtitle: 'Quản lý nhân sự',
      onTap: onTap,
      requiredPermissions:
          viewOnly
              ? [Permissions.viewHR]
              : [Permissions.viewHR, Permissions.manageHR],
      requireAnyPermission: true,
    );
  }
}

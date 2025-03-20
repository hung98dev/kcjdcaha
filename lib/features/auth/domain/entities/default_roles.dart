import 'package:sync_ops/features/auth/domain/entities/permission.dart';

/// Định nghĩa các role mặc định trong hệ thống
class DefaultRoles {
  // Role Admin - có toàn quyền trên hệ thống
  static const String admin = 'admin';
  static final List<String> adminPermissions = [
    // CRM Permissions
    Permissions.viewCustomers,
    Permissions.manageCustomers,
    Permissions.viewLeads,
    Permissions.manageLeads,

    // WMS Permissions
    Permissions.viewInventory,
    Permissions.manageInventory,
    Permissions.viewWarehouses,
    Permissions.manageWarehouses,

    // MES Permissions
    Permissions.viewProduction,
    Permissions.manageProduction,
    Permissions.viewQuality,
    Permissions.manageQuality,

    // ERP Permissions
    Permissions.viewFinance,
    Permissions.manageFinance,
    Permissions.viewHR,
    Permissions.manageHR,

    // Admin Permissions
    Permissions.viewUsers,
    Permissions.manageUsers,
    Permissions.viewRoles,
    Permissions.manageRoles,
    Permissions.viewSettings,
    Permissions.manageSettings,
  ];

  // Role Manager - có quyền quản lý nhưng không có quyền admin
  static const String manager = 'manager';
  static final List<String> managerPermissions = [
    // CRM Permissions
    Permissions.viewCustomers,
    Permissions.manageCustomers,
    Permissions.viewLeads,
    Permissions.manageLeads,

    // WMS Permissions
    Permissions.viewInventory,
    Permissions.manageInventory,
    Permissions.viewWarehouses,
    Permissions.manageWarehouses,

    // MES Permissions
    Permissions.viewProduction,
    Permissions.manageProduction,
    Permissions.viewQuality,
    Permissions.manageQuality,

    // ERP Permissions
    Permissions.viewFinance,
    Permissions.manageFinance,
    Permissions.viewHR,
    Permissions.manageHR,

    // Admin Permissions
    Permissions.viewUsers,
    Permissions.viewRoles,
    Permissions.viewSettings,
  ];

  // Role Staff - chỉ có quyền xem và thao tác cơ bản
  static const String staff = 'staff';
  static final List<String> staffPermissions = [
    // CRM Permissions
    Permissions.viewCustomers,
    Permissions.viewLeads,

    // WMS Permissions
    Permissions.viewInventory,
    Permissions.viewWarehouses,

    // MES Permissions
    Permissions.viewProduction,
    Permissions.viewQuality,

    // ERP Permissions
    Permissions.viewFinance,
    Permissions.viewHR,
  ];
}

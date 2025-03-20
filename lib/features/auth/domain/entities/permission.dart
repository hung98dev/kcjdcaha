import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission.freezed.dart';

@freezed
abstract class Permission with _$Permission {
  const factory Permission({
    required String id,
    required String name,
    required String description,
    required String module,
    required PermissionType type,
  }) = _Permission;
}

enum PermissionType { read, write, delete, manage }

// Định nghĩa các quyền cụ thể trong hệ thống
class Permissions {
  // Account 
  static const String allAccount = 'account.all';
  // CRM Permissions
  static const String viewCustomers = 'crm.customers.read';
  static const String manageCustomers = 'crm.customers.manage';
  static const String viewLeads = 'crm.leads.read';
  static const String manageLeads = 'crm.leads.manage';

  // WMS Permissions
  static const String viewInventory = 'wms.inventory.read';
  static const String manageInventory = 'wms.inventory.manage';
  static const String viewWarehouses = 'wms.warehouses.read';
  static const String manageWarehouses = 'wms.warehouses.manage';

  // MES Permissions
  static const String viewProduction = 'mes.production.read';
  static const String manageProduction = 'mes.production.manage';
  static const String viewQuality = 'mes.quality.read';
  static const String manageQuality = 'mes.quality.manage';

  // ERP Permissions
  static const String viewFinance = 'erp.finance.read';
  static const String manageFinance = 'erp.finance.manage';
  static const String viewHR = 'erp.hr.read';
  static const String manageHR = 'erp.hr.manage';

  // Admin Permissions
  static const String viewUsers = 'admin.users.read';
  static const String manageUsers = 'admin.users.manage';
  static const String viewRoles = 'admin.roles.read';
  static const String manageRoles = 'admin.roles.manage';
  static const String viewSettings = 'admin.settings.read';
  static const String manageSettings = 'admin.settings.manage';
}

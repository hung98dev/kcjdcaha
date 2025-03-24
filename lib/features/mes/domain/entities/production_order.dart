import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_order.freezed.dart';

/// Entity đại diện cho một lệnh sản xuất trong hệ thống MES
@freezed
abstract class ProductionOrder with _$ProductionOrder {
  const ProductionOrder._();
  const factory ProductionOrder({
    /// Mã lệnh sản xuất - định danh duy nhất
    required String id,

    /// Mức độ ưu tiên của lệnh sản xuất
    required PriorityLevel priority,

    /// Ghi chú từ bộ phận quản lý sản xuất
    String? note,

    /// Số lượng cần sản xuất theo kế hoạch
    required int plannedQuantity,

    /// Số lượng đã sản xuất (hoàn thành)
    @Default(0) int completedQuantity,

    /// Ngày bắt đầu sản xuất theo kế hoạch
    required DateTime plannedStartDate,

    /// Ngày kết thúc dự kiến
    required DateTime plannedEndDate,

    /// Ngày hoàn thành thực tế (null nếu chưa hoàn thành)
    DateTime? actualEndDate,
  }) = _ProductionOrder;

  /// Tính toán tiến độ hoàn thành (phần trăm)
  double get progressPercentage {
    if (plannedQuantity == 0) return 0;
    return (completedQuantity / plannedQuantity) * 100;
  }

  /// Kiểm tra xem lệnh sản xuất đã hoàn thành chưa
  bool get isCompleted => actualEndDate != null;
}

/// Enum đại diện cho các mức độ ưu tiên của lệnh sản xuất
enum PriorityLevel {
  high, // Cao
  medium, // Trung bình
  low; // Thấp

  /// Chuyển đổi enum thành chuỗi hiển thị
  String get displayName {
    switch (this) {
      case PriorityLevel.high:
        return 'Cao';
      case PriorityLevel.medium:
        return 'Trung bình';
      case PriorityLevel.low:
        return 'Thấp';
    }
  }
}

/// Enum đại diện cho các mức độ ưu tiên của lệnh sản xuất (dùng cho UI)
enum ProductionOrderPriority {
  high, // Cao
  medium, // Trung bình
  low; // Thấp

  /// Chuyển đổi enum thành chuỗi hiển thị
  String get displayName {
    switch (this) {
      case ProductionOrderPriority.high:
        return 'Cao';
      case ProductionOrderPriority.medium:
        return 'Trung bình';
      case ProductionOrderPriority.low:
        return 'Thấp';
    }
  }
}

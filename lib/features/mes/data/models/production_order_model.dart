import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';

part 'production_order_model.freezed.dart';
part 'production_order_model.g.dart';

/// Model đại diện cho một lệnh sản xuất trong hệ thống MES
@freezed
abstract class ProductionOrderModel with _$ProductionOrderModel {
  const ProductionOrderModel._(); // Constructor riêng tư cho các phương thức instance

  const factory ProductionOrderModel({
    /// Mã lệnh sản xuất - định danh duy nhất
    required String id,

    /// Mức độ ưu tiên của lệnh sản xuất
    required String priority,

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
  }) = _ProductionOrderModel;

  /// Tạo model từ JSON
  factory ProductionOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionOrderModelFromJson(json);

  /// Chuyển đổi model thành entity
  ProductionOrder toEntity() {
    return ProductionOrder(
      id: id,
      priority: _mapStringToPriorityLevel(priority),
      note: note,
      plannedQuantity: plannedQuantity,
      completedQuantity: completedQuantity,
      plannedStartDate: plannedStartDate,
      plannedEndDate: plannedEndDate,
      actualEndDate: actualEndDate,
    );
  }

  /// Chuyển đổi chuỗi ưu tiên thành enum PriorityLevel
  static PriorityLevel _mapStringToPriorityLevel(String priority) {
    return switch (priority.toLowerCase()) {
      'high' || 'cao' => PriorityLevel.high,
      'medium' || 'trung bình' => PriorityLevel.medium,
      'low' || 'thấp' => PriorityLevel.low,
      _ => PriorityLevel.medium, // Giá trị mặc định
    };
  }
}

/// Extension để xử lý danh sách ProductionOrderModel
extension ProductionOrderModelListX on List<ProductionOrderModel> {
  /// Chuyển đổi danh sách model thành danh sách entity
  List<ProductionOrder> toEntityList() {
    return map((model) => model.toEntity()).toList();
  }
}

/// Extension cho List<dynamic> để tạo danh sách model từ JSON
extension DynamicListX on List<dynamic> {
  /// Tạo danh sách ProductionOrderModel từ danh sách JSON
  List<ProductionOrderModel> toProductionOrderModelList() {
    return map(
      (json) => ProductionOrderModel.fromJson(json as Map<String, dynamic>),
    ).toList();
  }
}

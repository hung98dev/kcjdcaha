import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sync_ops/features/mes/domain/entities/quality_control_order.dart';

part 'quality_control_order_model.freezed.dart';
part 'quality_control_order_model.g.dart';

/// Model đại diện cho một lệnh kiểm tra chất lượng trong hệ thống MES
@freezed
abstract class QualityControlOrderModel with _$QualityControlOrderModel {
  const QualityControlOrderModel._(); // Constructor riêng tư cho các phương thức instance

  const factory QualityControlOrderModel({
    /// Mã lệnh kiểm tra - định danh duy nhất
    required String id,

    /// Công đoạn kiểm tra
    required String stage,

    /// Ghi chú từ bộ phận quản lý chất lượng
    String? note,

    /// Số lượng cần kiểm tra theo kế hoạch
    required int plannedQuantity,

    /// Số lượng đã kiểm tra
    @Default(0) int inspectedQuantity,

    /// Số lượng sản phẩm đạt yêu cầu
    @Default(0) int passedQuantity,

    /// Số lượng sản phẩm lỗi
    @Default(0) int failedQuantity,

    /// Trạng thái kiểm tra
    @Default('pending') String status,

    /// Hạn kiểm tra
    required DateTime deadline,

    /// Ngày hoàn thành thực tế (null nếu chưa hoàn thành)
    DateTime? completedDate,
  }) = _QualityControlOrderModel;

  /// Tạo model từ JSON
  factory QualityControlOrderModel.fromJson(Map<String, dynamic> json) =>
      _$QualityControlOrderModelFromJson(json);

  /// Chuyển đổi model thành entity
  QualityControlOrder toEntity() {
    return QualityControlOrder(
      id: id,
      stage: _mapStringToQualityControlStage(stage),
      note: note,
      plannedQuantity: plannedQuantity,
      inspectedQuantity: inspectedQuantity,
      passedQuantity: passedQuantity,
      failedQuantity: failedQuantity,
      status: _mapStringToQualityControlStatus(status),
      deadline: deadline,
      completedDate: completedDate,
    );
  }

  /// Chuyển đổi chuỗi thành QualityControlStage
  QualityControlStage _mapStringToQualityControlStage(String stage) {
    switch (stage) {
      case 'assembly':
        return QualityControlStage.assembly;
      case 'packaging':
        return QualityControlStage.packaging;
      case 'finalInspection':
        return QualityControlStage.finalInspection;
      case 'materialInspection':
        return QualityControlStage.materialInspection;
      default:
        return QualityControlStage.finalInspection; // Giá trị mặc định
    }
  }

  /// Chuyển đổi chuỗi thành QualityControlStatus
  QualityControlStatus _mapStringToQualityControlStatus(String status) {
    switch (status) {
      case 'pending':
        return QualityControlStatus.pending;
      case 'inProgress':
        return QualityControlStatus.inProgress;
      case 'completed':
        return QualityControlStatus.completed;
      default:
        return QualityControlStatus.pending; // Giá trị mặc định
    }
  }
}

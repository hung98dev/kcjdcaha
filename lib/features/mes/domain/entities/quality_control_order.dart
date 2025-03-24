import 'package:freezed_annotation/freezed_annotation.dart';

part 'quality_control_order.freezed.dart';

/// Entity đại diện cho một lệnh kiểm tra chất lượng trong hệ thống MES
@freezed
abstract class QualityControlOrder with _$QualityControlOrder {
  const QualityControlOrder._();
  const factory QualityControlOrder({
    /// Mã lệnh kiểm tra - định danh duy nhất
    required String id,

    /// Công đoạn kiểm tra
    required QualityControlStage stage,

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
    @Default(QualityControlStatus.pending) QualityControlStatus status,

    /// Hạn kiểm tra
    required DateTime deadline,

    /// Ngày hoàn thành thực tế (null nếu chưa hoàn thành)
    DateTime? completedDate,
  }) = _QualityControlOrder;

  /// Tính toán tiến độ hoàn thành (phần trăm)
  double get progressPercentage {
    if (plannedQuantity == 0) return 0;
    return (inspectedQuantity / plannedQuantity) * 100;
  }

  /// Kiểm tra xem lệnh kiểm tra đã hoàn thành chưa
  bool get isCompleted => status == QualityControlStatus.completed;
}

/// Enum đại diện cho các công đoạn kiểm tra chất lượng
enum QualityControlStage {
  assembly, // Lắp ráp
  packaging, // Đóng gói
  finalInspection, // Kiểm tra cuối
  materialInspection; // Kiểm tra nguyên vật liệu

  /// Chuyển đổi enum thành chuỗi hiển thị
  String toDisplayString() {
    switch (this) {
      case QualityControlStage.assembly:
        return 'Lắp ráp';
      case QualityControlStage.packaging:
        return 'Đóng gói';
      case QualityControlStage.finalInspection:
        return 'Kiểm tra cuối';
      case QualityControlStage.materialInspection:
        return 'Kiểm tra nguyên vật liệu';
    }
  }
}

/// Enum đại diện cho các trạng thái của lệnh kiểm tra chất lượng
enum QualityControlStatus {
  pending, // Chưa kiểm tra
  inProgress, // Đang kiểm tra
  completed; // Hoàn thành

  /// Chuyển đổi enum thành chuỗi hiển thị
  String toDisplayString() {
    switch (this) {
      case QualityControlStatus.pending:
        return 'Chưa kiểm tra';
      case QualityControlStatus.inProgress:
        return 'Đang kiểm tra';
      case QualityControlStatus.completed:
        return 'Hoàn thành';
    }
  }
}

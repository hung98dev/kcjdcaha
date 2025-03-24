// File này là một phần của quality_control_order_bloc.dart
part of 'quality_control_order_bloc.dart';

/// Các sự kiện của QualityControlOrderBloc
@freezed
class QualityControlOrderEvent with _$QualityControlOrderEvent {
  /// Sự kiện tải danh sách lệnh kiểm tra chất lượng
  const factory QualityControlOrderEvent.loadQualityControlOrders() =
      LoadQualityControlOrders;

  /// Sự kiện tải thêm lệnh kiểm tra chất lượng (pagination)
  const factory QualityControlOrderEvent.loadMoreQualityControlOrders() =
      LoadMoreQualityControlOrders;

  /// Sự kiện tìm kiếm lệnh kiểm tra chất lượng
  const factory QualityControlOrderEvent.searchQualityControlOrders({
    required String keyword,
  }) = SearchQualityControlOrders;

  /// Sự kiện xóa tìm kiếm và quay lại danh sách ban đầu
  const factory QualityControlOrderEvent.clearQualityControlOrderSearch() =
      ClearQualityControlOrderSearch;

  /// Sự kiện làm mới danh sách lệnh kiểm tra chất lượng
  const factory QualityControlOrderEvent.refreshQualityControlOrders() =
      RefreshQualityControlOrders;
}
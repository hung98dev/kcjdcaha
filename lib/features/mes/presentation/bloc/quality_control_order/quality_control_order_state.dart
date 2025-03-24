// File này là một phần của quality_control_order_bloc.dart
part of 'quality_control_order_bloc.dart';

/// Các trạng thái của QualityControlOrderBloc
@freezed
sealed class QualityControlOrderState with _$QualityControlOrderState {
  /// Trạng thái ban đầu
  const factory QualityControlOrderState.initial() = Initial;

  /// Trạng thái đang tải
  const factory QualityControlOrderState.loading() = Loading;

  /// Trạng thái đang tải thêm (pagination)
  const factory QualityControlOrderState.loadingMore({
    required List<QualityControlOrder> currentOrders,
    required int currentPage,
  }) = LoadingMore;

  /// Trạng thái tải thành công
  const factory QualityControlOrderState.loaded({
    required List<QualityControlOrder> orders,
    required int currentPage,
    required bool hasReachedMax,
  }) = Loaded;

  /// Trạng thái đang tìm kiếm
  const factory QualityControlOrderState.searching() = Searching;

  /// Trạng thái kết quả tìm kiếm
  const factory QualityControlOrderState.searchResult({
    required List<QualityControlOrder> orders,
    required String keyword,
  }) = SearchResult;

  /// Trạng thái lỗi
  const factory QualityControlOrderState.error({required String message}) =
      Error;
}
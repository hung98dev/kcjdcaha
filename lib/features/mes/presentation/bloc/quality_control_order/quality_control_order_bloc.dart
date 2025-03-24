import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/features/mes/domain/entities/quality_control_order.dart';
import 'package:sync_ops/features/mes/domain/usecases/get_quality_control_orders_usecase.dart';

// File được tạo tự động bởi freezed
part 'quality_control_order_bloc.freezed.dart';
part 'quality_control_order_event.dart';
part 'quality_control_order_state.dart';

/// Số lượng lệnh kiểm tra chất lượng trên mỗi trang
const int _pageSize = 30;

/// Bloc quản lý trạng thái của trang quản lý lệnh kiểm tra chất lượng
@injectable
class QualityControlOrderBloc
    extends Bloc<QualityControlOrderEvent, QualityControlOrderState> {
  final GetQualityControlOrdersUseCase _getQualityControlOrdersUseCase;

  QualityControlOrderBloc(this._getQualityControlOrdersUseCase)
    : super(const QualityControlOrderState.initial()) {
    on<LoadQualityControlOrders>(_onLoadQualityControlOrders);
    on<LoadMoreQualityControlOrders>(_onLoadMoreQualityControlOrders);
    on<SearchQualityControlOrders>(_onSearchQualityControlOrders);
    on<ClearQualityControlOrderSearch>(_onClearQualityControlOrderSearch);
    on<RefreshQualityControlOrders>(_onRefreshQualityControlOrders);
  }

  /// Xử lý sự kiện tải danh sách lệnh kiểm tra chất lượng ban đầu
  Future<void> _onLoadQualityControlOrders(
    LoadQualityControlOrders event,
    Emitter<QualityControlOrderState> emit,
  ) async {
    emit(const QualityControlOrderState.loading());

    final result = await _getQualityControlOrdersUseCase(
      Params(page: 1, pageSize: _pageSize),
    );

    result.fold(
      (failure) => emit(
        QualityControlOrderState.error(
          message: 'Lỗi khi tải danh sách lệnh kiểm tra chất lượng.',
        ),
      ),
      (orders) => emit(
        QualityControlOrderState.loaded(
          orders: orders,
          currentPage: 1,
          hasReachedMax: orders.length < _pageSize,
        ),
      ),
    );
  }

  /// Xử lý sự kiện tải thêm lệnh kiểm tra chất lượng (pagination)
  Future<void> _onLoadMoreQualityControlOrders(
    LoadMoreQualityControlOrders event,
    Emitter<QualityControlOrderState> emit,
  ) async {
    final currentState = state;
    if (currentState is Loaded) {
      if (currentState.hasReachedMax) return;

      emit(
        QualityControlOrderState.loadingMore(
          currentOrders: currentState.orders,
          currentPage: currentState.currentPage,
        ),
      );

      final nextPage = currentState.currentPage + 1;
      final result = await _getQualityControlOrdersUseCase(
        Params(page: nextPage, pageSize: _pageSize),
      );

      result.fold(
        (failure) => emit(
          QualityControlOrderState.error(
            message: 'Lỗi khi tải danh sách lệnh kiểm tra chất lượng.',
          ),
        ),
        (newOrders) {
          final allOrders = List.of(currentState.orders)..addAll(newOrders);
          emit(
            QualityControlOrderState.loaded(
              orders: allOrders,
              currentPage: nextPage,
              hasReachedMax: newOrders.length < _pageSize,
            ),
          );
        },
      );
    }
  }

  /// Xử lý sự kiện tìm kiếm lệnh kiểm tra chất lượng
  Future<void> _onSearchQualityControlOrders(
    SearchQualityControlOrders event,
    Emitter<QualityControlOrderState> emit,
  ) async {
    emit(const QualityControlOrderState.searching());

    // Giả định có SearchQualityControlOrdersUseCase
    // Trong trường hợp này, sử dụng GetQualityControlOrdersUseCase với filter
    final result = await _getQualityControlOrdersUseCase(
      Params(page: 1, pageSize: 100, keyword: event.keyword),
    );

    result.fold(
      (failure) => emit(
        QualityControlOrderState.error(
          message: 'Lỗi khi tìm kiếm lệnh kiểm tra chất lượng.',
        ),
      ),
      (orders) => emit(
        QualityControlOrderState.searchResult(
          orders: orders,
          keyword: event.keyword,
        ),
      ),
    );
  }

  /// Xử lý sự kiện xóa tìm kiếm và quay lại danh sách ban đầu
  Future<void> _onClearQualityControlOrderSearch(
    ClearQualityControlOrderSearch event,
    Emitter<QualityControlOrderState> emit,
  ) async {
    add(const QualityControlOrderEvent.loadQualityControlOrders());
  }

  /// Xử lý sự kiện làm mới danh sách lệnh kiểm tra chất lượng
  Future<void> _onRefreshQualityControlOrders(
    RefreshQualityControlOrders event,
    Emitter<QualityControlOrderState> emit,
  ) async {
    add(const QualityControlOrderEvent.loadQualityControlOrders());
  }
}

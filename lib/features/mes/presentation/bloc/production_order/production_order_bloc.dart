import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/features/mes/domain/usecases/get_production_orders_usecase.dart'
    as get_orders;
import 'package:sync_ops/features/mes/domain/usecases/search_production_orders_usecase.dart'
    as search_orders;
import 'package:sync_ops/features/mes/presentation/bloc/production_order/production_order_event.dart';
import 'package:sync_ops/features/mes/presentation/bloc/production_order/production_order_state.dart';

/// Số lượng lệnh sản xuất trên mỗi trang
const int _pageSize = 30;

/// Bloc quản lý trạng thái của trang quản lý lệnh sản xuất
@injectable
class ProductionOrderBloc
    extends Bloc<ProductionOrderEvent, ProductionOrderState> {
  final get_orders.GetProductionOrdersUseCase _getProductionOrdersUseCase;
  final search_orders.SearchProductionOrdersUseCase
  _searchProductionOrdersUseCase;

  ProductionOrderBloc(
    this._getProductionOrdersUseCase,
    this._searchProductionOrdersUseCase,
  ) : super(const ProductionOrderInitial()) {
    on<LoadProductionOrders>(_onLoadProductionOrders);
    on<LoadMoreProductionOrders>(_onLoadMoreProductionOrders);
    on<SearchProductionOrders>(_onSearchProductionOrders);
    on<ClearProductionOrderSearch>(_onClearProductionOrderSearch);
    on<RefreshProductionOrders>(_onRefreshProductionOrders);
  }

  /// Xử lý sự kiện tải danh sách lệnh sản xuất ban đầu
  Future<void> _onLoadProductionOrders(
    LoadProductionOrders event,
    Emitter<ProductionOrderState> emit,
  ) async {
    emit(const ProductionOrderLoading());

    final result = await _getProductionOrdersUseCase(
      const get_orders.Params(page: 1, pageSize: _pageSize),
    );

    result.fold(
      (failure) => emit(ProductionOrderError(message: 'Lỗi khi tải danh sách lệnh sản xuất.')),
      (orders) => emit(
        ProductionOrderLoaded(
          orders: orders,
          currentPage: 1,
          hasReachedMax: orders.length < _pageSize,
        ),
      ),
    );
  }

  /// Xử lý sự kiện tải thêm lệnh sản xuất (pagination)
  Future<void> _onLoadMoreProductionOrders(
    LoadMoreProductionOrders event,
    Emitter<ProductionOrderState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductionOrderLoaded) {
      if (currentState.hasReachedMax) return;

      emit(
        ProductionOrderLoadingMore(
          currentOrders: currentState.orders,
          currentPage: currentState.currentPage,
        ),
      );

      final nextPage = currentState.currentPage + 1;
      final result = await _getProductionOrdersUseCase(
        get_orders.Params(page: nextPage, pageSize: _pageSize),
      );

      result.fold(
        (failure) => emit(ProductionOrderError(message: 'Lỗi khi tải danh sách lệnh sản xuất.')),
        (newOrders) {
          final allOrders = List.of(currentState.orders)..addAll(newOrders);
          emit(
            ProductionOrderLoaded(
              orders: allOrders,
              currentPage: nextPage,
              hasReachedMax: newOrders.length < _pageSize,
            ),
          );
        },
      );
    }
  }

  /// Xử lý sự kiện tìm kiếm lệnh sản xuất
  Future<void> _onSearchProductionOrders(
    SearchProductionOrders event,
    Emitter<ProductionOrderState> emit,
  ) async {
    emit(const ProductionOrderSearching());

    final result = await _searchProductionOrdersUseCase(
      search_orders.Params(keyword: event.keyword),
    );

    result.fold(
      (failure) => emit(ProductionOrderError(message: 'Lỗi khi tìm kiếm lệnh sản xuất.')),
      (orders) => emit(
        ProductionOrderSearchResult(orders: orders, keyword: event.keyword),
      ),
    );
  }

  /// Xử lý sự kiện xóa tìm kiếm và quay lại danh sách ban đầu
  Future<void> _onClearProductionOrderSearch(
    ClearProductionOrderSearch event,
    Emitter<ProductionOrderState> emit,
  ) async {
    add(const LoadProductionOrders());
  }

  /// Xử lý sự kiện làm mới danh sách lệnh sản xuất
  Future<void> _onRefreshProductionOrders(
    RefreshProductionOrders event,
    Emitter<ProductionOrderState> emit,
  ) async {
    add(const LoadProductionOrders());
  }
}

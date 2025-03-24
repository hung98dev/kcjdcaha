import 'package:equatable/equatable.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';

/// Các trạng thái của ProductionOrderBloc
abstract class ProductionOrderState extends Equatable {
  const ProductionOrderState();

  @override
  List<Object> get props => [];
}

/// Trạng thái ban đầu
class ProductionOrderInitial extends ProductionOrderState {
  const ProductionOrderInitial();
}

/// Trạng thái đang tải
class ProductionOrderLoading extends ProductionOrderState {
  const ProductionOrderLoading();
}

/// Trạng thái đang tải thêm (pagination)
class ProductionOrderLoadingMore extends ProductionOrderState {
  final List<ProductionOrder> currentOrders;
  final int currentPage;

  const ProductionOrderLoadingMore({
    required this.currentOrders,
    required this.currentPage,
  });

  @override
  List<Object> get props => [currentOrders, currentPage];
}

/// Trạng thái tải thành công
class ProductionOrderLoaded extends ProductionOrderState {
  final List<ProductionOrder> orders;
  final int currentPage;
  final bool hasReachedMax;

  const ProductionOrderLoaded({
    required this.orders,
    required this.currentPage,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [orders, currentPage, hasReachedMax];

  /// Tạo bản sao với các giá trị mới
  ProductionOrderLoaded copyWith({
    List<ProductionOrder>? orders,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return ProductionOrderLoaded(
      orders: orders ?? this.orders,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

/// Trạng thái tìm kiếm
class ProductionOrderSearching extends ProductionOrderState {
  const ProductionOrderSearching();
}

/// Trạng thái tìm kiếm thành công
class ProductionOrderSearchResult extends ProductionOrderState {
  final List<ProductionOrder> orders;
  final String keyword;

  const ProductionOrderSearchResult({
    required this.orders,
    required this.keyword,
  });

  @override
  List<Object> get props => [orders, keyword];
}

/// Trạng thái lỗi
class ProductionOrderError extends ProductionOrderState {
  final String message;

  const ProductionOrderError({required this.message});

  @override
  List<Object> get props => [message];
}

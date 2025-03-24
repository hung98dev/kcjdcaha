import 'package:equatable/equatable.dart';

/// Các sự kiện của ProductionOrderBloc
abstract class ProductionOrderEvent extends Equatable {
  const ProductionOrderEvent();

  @override
  List<Object> get props => [];
}

/// Sự kiện tải danh sách lệnh sản xuất ban đầu
class LoadProductionOrders extends ProductionOrderEvent {
  const LoadProductionOrders();
}

/// Sự kiện tải thêm lệnh sản xuất (pagination)
class LoadMoreProductionOrders extends ProductionOrderEvent {
  const LoadMoreProductionOrders();
}

/// Sự kiện tìm kiếm lệnh sản xuất
class SearchProductionOrders extends ProductionOrderEvent {
  final String keyword;

  const SearchProductionOrders({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

/// Sự kiện xóa tìm kiếm và quay lại danh sách ban đầu
class ClearProductionOrderSearch extends ProductionOrderEvent {
  const ClearProductionOrderSearch();
}

/// Sự kiện làm mới danh sách lệnh sản xuất
class RefreshProductionOrders extends ProductionOrderEvent {
  const RefreshProductionOrders();
}

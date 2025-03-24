import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';
import 'package:sync_ops/features/mes/domain/repositories/production_order_repository.dart';

/// Use case để tìm kiếm lệnh sản xuất theo từ khóa
@injectable
class SearchProductionOrdersUseCase {
  final ProductionOrderRepository repository;

  SearchProductionOrdersUseCase(this.repository);

  /// Gọi use case với tham số [params]
  Future<Either<Failure, List<ProductionOrder>>> call(Params params) async {
    return await repository.searchProductionOrders(keyword: params.keyword);
  }
}

/// Tham số cho SearchProductionOrdersUseCase
class Params extends Equatable {
  final String keyword;

  const Params({required this.keyword});

  @override
  List<Object> get props => [keyword];
}

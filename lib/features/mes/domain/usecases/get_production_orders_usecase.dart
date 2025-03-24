import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';
import 'package:sync_ops/features/mes/domain/repositories/production_order_repository.dart';

part 'get_production_orders_usecase.freezed.dart';

/// Use case để lấy danh sách lệnh sản xuất với phân trang
@injectable
class GetProductionOrdersUseCase {
  final ProductionOrderRepository repository;

  GetProductionOrdersUseCase(this.repository);

  /// Gọi use case với tham số [params]
  Future<Either<Failure, List<ProductionOrder>>> call(Params params) async {
    return await repository.getProductionOrders(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

/// Tham số cho GetProductionOrdersUseCase
@freezed
abstract class Params with _$Params {
  const factory Params({
    required int page,
    required int pageSize,
    String? keyword,
  }) = _Params;
}

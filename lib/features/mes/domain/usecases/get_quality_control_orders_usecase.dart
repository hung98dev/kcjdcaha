import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/mes/domain/entities/quality_control_order.dart';
import 'package:sync_ops/features/mes/domain/repositories/quality_control_order_repository.dart';

part 'get_quality_control_orders_usecase.freezed.dart';

/// Use case để lấy danh sách lệnh kiểm tra chất lượng với phân trang
@injectable
class GetQualityControlOrdersUseCase {
  final QualityControlOrderRepository repository;

  GetQualityControlOrdersUseCase(this.repository);

  /// Gọi use case với tham số [params]
  Future<Either<Failure, List<QualityControlOrder>>> call(Params params) async {
    return await repository.getQualityControlOrders(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

/// Tham số cho GetQualityControlOrdersUseCase
@freezed
abstract class Params with _$Params {
  const factory Params({
    required int page,
    required int pageSize,
    String? keyword,
  }) = _Params;
}

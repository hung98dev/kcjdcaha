import 'package:dartz/dartz.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';

/// Repository interface cho việc quản lý lệnh sản xuất
abstract class ProductionOrderRepository {
  /// Lấy danh sách lệnh sản xuất với phân trang
  /// [page] là số trang hiện tại, bắt đầu từ 1
  /// [pageSize] là số lượng lệnh sản xuất trên mỗi trang
  Future<Either<Failure, List<ProductionOrder>>> getProductionOrders({
    required int page,
    required int pageSize,
  });

  /// Tìm kiếm lệnh sản xuất theo từ khóa
  /// [keyword] là từ khóa tìm kiếm (mã lệnh sản xuất, ghi chú, ...)
  Future<Either<Failure, List<ProductionOrder>>> searchProductionOrders({
    required String keyword,
  });

  /// Lấy chi tiết lệnh sản xuất theo ID
  /// [id] là mã định danh của lệnh sản xuất
  Future<Either<Failure, ProductionOrder>> getProductionOrderById({
    required String id,
  });
}

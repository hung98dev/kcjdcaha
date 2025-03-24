import 'package:dartz/dartz.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/mes/domain/entities/quality_control_order.dart';

/// Repository interface cho việc quản lý lệnh kiểm tra chất lượng
abstract class QualityControlOrderRepository {
  /// Lấy danh sách lệnh kiểm tra chất lượng với phân trang
  /// [page] là số trang hiện tại, bắt đầu từ 1
  /// [pageSize] là số lượng lệnh kiểm tra chất lượng trên mỗi trang
  Future<Either<Failure, List<QualityControlOrder>>> getQualityControlOrders({
    required int page,
    required int pageSize,
  });

  /// Tìm kiếm lệnh kiểm tra chất lượng theo từ khóa
  /// [keyword] là từ khóa tìm kiếm (mã lệnh kiểm tra, ghi chú, ...)
  Future<Either<Failure, List<QualityControlOrder>>>
  searchQualityControlOrders({required String keyword});

  /// Lấy chi tiết lệnh kiểm tra chất lượng theo ID
  /// [id] là mã định danh của lệnh kiểm tra chất lượng
  Future<Either<Failure, QualityControlOrder>> getQualityControlOrderById({
    required String id,
  });
}

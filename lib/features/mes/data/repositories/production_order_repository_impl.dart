import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/core/network/network_info.dart';
import 'package:sync_ops/features/mes/data/datasources/production_order_remote_data_source.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';
import 'package:sync_ops/features/mes/domain/repositories/production_order_repository.dart';

/// Implementation của ProductionOrderRepository
@LazySingleton(as: ProductionOrderRepository)
class ProductionOrderRepositoryImpl implements ProductionOrderRepository {
  final ProductionOrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductionOrderRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  /// Tạo dữ liệu ảo cho danh sách lệnh sản xuất
  /// [page] là số trang hiện tại
  /// [pageSize] là số lượng lệnh sản xuất trên mỗi trang
  List<ProductionOrder> _generateMockProductionOrders(int page, int pageSize) {
    final List<ProductionOrder> mockOrders = [];
    final int startIndex = (page - 1) * pageSize;

    for (int i = 0; i < pageSize; i++) {
      final int orderNumber = startIndex + i + 1;
      final String orderId =
          'PO-${DateTime.now().year}-${orderNumber.toString().padLeft(5, '0')}';

      // Tạo ngày bắt đầu và kết thúc ngẫu nhiên
      final DateTime now = DateTime.now();
      final DateTime startDate = now.subtract(Duration(days: 30 + i % 10));
      final DateTime endDate = startDate.add(Duration(days: 15 + i % 20));

      // Xác định xem lệnh sản xuất đã hoàn thành chưa
      final bool isCompleted = i % 3 == 0;
      final DateTime? actualEndDate =
          isCompleted ? endDate.subtract(Duration(days: 2)) : null;

      // Tạo số lượng kế hoạch và đã hoàn thành
      final int plannedQty = 100 + (i * 50);
      final int completedQty =
          isCompleted ? plannedQty : (plannedQty * (i % 10) / 10).round();

      // Xác định mức độ ưu tiên
      final PriorityLevel priority =
          i % 3 == 0
              ? PriorityLevel.high
              : (i % 3 == 1 ? PriorityLevel.medium : PriorityLevel.low);

      mockOrders.add(
        ProductionOrder(
          id: orderId,
          priority: priority,
          note: 'Ghi chú cho lệnh sản xuất $orderId',
          plannedQuantity: plannedQty,
          completedQuantity: completedQty,
          plannedStartDate: startDate,
          plannedEndDate: endDate,
          actualEndDate: actualEndDate,
        ),
      );
    }

    return mockOrders;
  }

  @override
  Future<Either<Failure, List<ProductionOrder>>> getProductionOrders({
    required int page,
    required int pageSize,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        // final orderModels = await remoteDataSource.getProductionOrders(
        //   page: page,
        //   pageSize: pageSize,
        // );
        // return Right(orderModels.map((model) => model.toEntity()).toList());
        return Right(_generateMockProductionOrders(page, pageSize));
      } on ServerException {
        return Left(ServerFailure());
        //return Right(_generateMockProductionOrders(page, pageSize));
      } catch (e) {
        //return Left(ServerFailure());
        return Right(_generateMockProductionOrders(page, pageSize));
      }
    } else {
      //return Left(ServerFailure());
      return Right(_generateMockProductionOrders(page, pageSize));
    }
  }

  @override
  Future<Either<Failure, List<ProductionOrder>>> searchProductionOrders({
    required String keyword,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final orderModels = await remoteDataSource.searchProductionOrders(
          keyword: keyword,
        );
        return Right(orderModels.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, ProductionOrder>> getProductionOrderById({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final orderModel = await remoteDataSource.getProductionOrderById(
          id: id,
        );
        return Right(orderModel.toEntity());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

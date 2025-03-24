import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/core/network/network_info.dart';
import 'package:sync_ops/features/mes/data/datasources/quality_control_order_remote_data_source.dart';
import 'package:sync_ops/features/mes/domain/entities/quality_control_order.dart';
import 'package:sync_ops/features/mes/domain/repositories/quality_control_order_repository.dart';

/// Implementation của QualityControlOrderRepository
@LazySingleton(as: QualityControlOrderRepository)
class QualityControlOrderRepositoryImpl
    implements QualityControlOrderRepository {
  final QualityControlOrderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  QualityControlOrderRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  /// Tạo dữ liệu ảo cho danh sách lệnh kiểm tra chất lượng
  /// [page] là số trang hiện tại
  /// [pageSize] là số lượng lệnh kiểm tra chất lượng trên mỗi trang
  List<QualityControlOrder> _generateMockQualityControlOrders(
    int page,
    int pageSize,
  ) {
    final List<QualityControlOrder> mockOrders = [];
    final int startIndex = (page - 1) * pageSize;

    for (int i = 0; i < pageSize; i++) {
      final int orderNumber = startIndex + i + 1;
      final String orderId =
          'QC-${DateTime.now().year}-${orderNumber.toString().padLeft(5, '0')}';

      // Tạo hạn kiểm tra ngẫu nhiên
      final DateTime now = DateTime.now();
      final DateTime deadline = now.add(Duration(days: 5 + i % 10));

      // Xác định trạng thái kiểm tra
      final QualityControlStatus status =
          i % 3 == 0
              ? QualityControlStatus.completed
              : (i % 3 == 1
                  ? QualityControlStatus.inProgress
                  : QualityControlStatus.pending);

      // Tạo số lượng cần kiểm tra và đã kiểm tra
      final int plannedQty = 50 + (i * 20);
      final int inspectedQty =
          status == QualityControlStatus.completed
              ? plannedQty
              : (status == QualityControlStatus.inProgress
                  ? (plannedQty * (30 + i % 50) / 100).round()
                  : 0);

      // Tính toán số lượng đạt và không đạt
      final int passedQty = (inspectedQty * (80 + i % 20) / 100).round();
      final int failedQty = inspectedQty - passedQty;

      // Xác định công đoạn kiểm tra
      final QualityControlStage stage =
          QualityControlStage.values[i % QualityControlStage.values.length];

      // Ngày hoàn thành thực tế
      final DateTime? completedDate =
          status == QualityControlStatus.completed
              ? deadline.subtract(Duration(days: 1 + i % 3))
              : null;

      mockOrders.add(
        QualityControlOrder(
          id: orderId,
          stage: stage,
          note: 'Ghi chú cho lệnh kiểm tra $orderId',
          plannedQuantity: plannedQty,
          inspectedQuantity: inspectedQty,
          passedQuantity: passedQty,
          failedQuantity: failedQty,
          status: status,
          deadline: deadline,
          completedDate: completedDate,
        ),
      );
    }

    return mockOrders;
  }

  @override
  Future<Either<Failure, List<QualityControlOrder>>> getQualityControlOrders({
    required int page,
    required int pageSize,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        // final models = await remoteDataSource.getQualityControlOrders(
        //   page: page,
        //   pageSize: pageSize,
        // );
        // final entities = models.map((model) => model.toEntity()).toList();
        // return Right(entities);

        return Right(_generateMockQualityControlOrders(page, pageSize));
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<QualityControlOrder>>>
  searchQualityControlOrders({required String keyword}) async {
    if (await networkInfo.isConnected) {
      try {
        // final models = await remoteDataSource.searchQualityControlOrders(
        //   keyword: keyword,
        // );
        // final entities = models.map((model) => model.toEntity()).toList();
        // return Right(entities);
        return Right(
          _generateMockQualityControlOrders(1, 5)
              .where(
                (order) =>
                    order.id.toLowerCase().contains(keyword.toLowerCase()) ||
                    (order.note?.toLowerCase().contains(
                          keyword.toLowerCase(),
                        ) ??
                        false),
              )
              .toList(),
        );
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, QualityControlOrder>> getQualityControlOrderById({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        // final model = await remoteDataSource.getQualityControlOrderById(id: id);
        // return Right(model.toEntity());
        // Tạo một lệnh kiểm tra ảo khi không tìm thấy lệnh với ID cụ thể
        final mockOrders = _generateMockQualityControlOrders(1, 10);
        final foundOrder = mockOrders.firstWhere(
          (order) => order.id == id,
          orElse: () => mockOrders.first,
        );
        return Right(foundOrder);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}

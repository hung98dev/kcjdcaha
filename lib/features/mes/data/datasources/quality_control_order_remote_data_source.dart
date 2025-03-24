import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/constants/api_constants.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/core/network/api_client.dart';
import 'package:sync_ops/features/mes/data/models/quality_control_order_model.dart';

/// Interface cho QualityControlOrderRemoteDataSource
abstract class QualityControlOrderRemoteDataSource {
  /// Lấy danh sách lệnh kiểm tra chất lượng với phân trang
  Future<List<QualityControlOrderModel>> getQualityControlOrders({
    required int page,
    required int pageSize,
  });

  /// Tìm kiếm lệnh kiểm tra chất lượng theo từ khóa
  Future<List<QualityControlOrderModel>> searchQualityControlOrders({
    required String keyword,
  });

  /// Lấy chi tiết lệnh kiểm tra chất lượng theo ID
  Future<QualityControlOrderModel> getQualityControlOrderById({
    required String id,
  });
}

/// Extension để chuyển đổi List<dynamic> thành List<QualityControlOrderModel>
extension QualityControlOrderListConverter on List<dynamic> {
  List<QualityControlOrderModel> toQualityControlOrderModelList() {
    return map(
      (json) => QualityControlOrderModel.fromJson(json as Map<String, dynamic>),
    ).toList();
  }
}

/// Implementation của QualityControlOrderRemoteDataSource
@LazySingleton(as: QualityControlOrderRemoteDataSource)
class QualityControlOrderRemoteDataSourceImpl
    implements QualityControlOrderRemoteDataSource {
  final ApiClient client;

  QualityControlOrderRemoteDataSourceImpl(ApiClient apiClient, {required this.client});

  @override
  Future<List<QualityControlOrderModel>> getQualityControlOrders({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await client.get(
        '${ApiConstants.baseUrl}/mes/quality-control-orders',
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> ordersJson = response.data['data'];
        return ordersJson.toQualityControlOrderModelList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<QualityControlOrderModel>> searchQualityControlOrders({
    required String keyword,
  }) async {
    try {
      final response = await client.get(
        '${ApiConstants.baseUrl}/mes/quality-control-orders/search',
        queryParameters: {'keyword': keyword},
      );

      if (response.statusCode == 200) {
        final List<dynamic> ordersJson = response.data['data'];
        return ordersJson.toQualityControlOrderModelList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<QualityControlOrderModel> getQualityControlOrderById({
    required String id,
  }) async {
    try {
      final response = await client.get(
        '${ApiConstants.baseUrl}/mes/quality-control-orders/$id',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> orderJson = response.data['data'];
        return QualityControlOrderModel.fromJson(orderJson);
      } else if (response.statusCode == 404) {
        throw NotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException();
    }
  }
}

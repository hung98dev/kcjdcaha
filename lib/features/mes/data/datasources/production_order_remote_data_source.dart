import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/constants/api_constants.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/core/network/api_client.dart';
import 'package:sync_ops/features/mes/data/models/production_order_model.dart';

/// Interface cho ProductionOrderRemoteDataSource
abstract class ProductionOrderRemoteDataSource {
  /// Lấy danh sách lệnh sản xuất với phân trang
  Future<List<ProductionOrderModel>> getProductionOrders({
    required int page,
    required int pageSize,
  });

  /// Tìm kiếm lệnh sản xuất theo từ khóa
  Future<List<ProductionOrderModel>> searchProductionOrders({
    required String keyword,
  });

  /// Lấy chi tiết lệnh sản xuất theo ID
  Future<ProductionOrderModel> getProductionOrderById({required String id});
}

/// Implementation của ProductionOrderRemoteDataSource
@LazySingleton(as: ProductionOrderRemoteDataSource)
class ProductionOrderRemoteDataSourceImpl
    implements ProductionOrderRemoteDataSource {
  final ApiClient client;

  ProductionOrderRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductionOrderModel>> getProductionOrders({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await client.get(
        '${ApiConstants.baseUrl}/mes/production-orders',
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> ordersJson = response.data['data'];
        return ordersJson.toProductionOrderModelList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductionOrderModel>> searchProductionOrders({
    required String keyword,
  }) async {
    try {
      final response = await client.get(
        '${ApiConstants.baseUrl}/mes/production-orders/search',
        queryParameters: {'keyword': keyword},
      );

      if (response.statusCode == 200) {
        final List<dynamic> ordersJson = response.data['data'];
        return ordersJson.toProductionOrderModelList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductionOrderModel> getProductionOrderById({
    required String id,
  }) async {
    try {
      final response = await client.get(
        '${ApiConstants.baseUrl}/mes/production-orders/$id',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> orderJson = response.data['data'];
        return ProductionOrderModel.fromJson(orderJson);
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
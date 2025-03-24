import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/exceptions.dart';

/// Lớp ApiClient cung cấp các phương thức để gọi API
/// Sử dụng thư viện http để thực hiện các request
@lazySingleton
class ApiClient {
  final http.Client _httpClient;

  ApiClient(this._httpClient);

  /// Thực hiện HTTP GET request
  /// [url]: Đường dẫn API endpoint
  /// [headers]: Headers của request (optional)
  /// [queryParameters]: Query parameters (optional)
  Future<ApiResponse> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final response = await _httpClient.get(
        uri,
        headers: headers ?? _getDefaultHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  /// Thực hiện HTTP POST request
  /// [url]: Đường dẫn API endpoint
  /// [body]: Body của request (optional)
  /// [headers]: Headers của request (optional)
  /// [queryParameters]: Query parameters (optional)
  Future<ApiResponse> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final response = await _httpClient.post(
        uri,
        headers: headers ?? _getDefaultHeaders(),
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  /// Thực hiện HTTP PUT request
  /// [url]: Đường dẫn API endpoint
  /// [body]: Body của request (optional)
  /// [headers]: Headers của request (optional)
  /// [queryParameters]: Query parameters (optional)
  Future<ApiResponse> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final response = await _httpClient.put(
        uri,
        headers: headers ?? _getDefaultHeaders(),
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  /// Thực hiện HTTP DELETE request
  /// [url]: Đường dẫn API endpoint
  /// [headers]: Headers của request (optional)
  /// [queryParameters]: Query parameters (optional)
  Future<ApiResponse> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = _buildUri(url, queryParameters);
      final response = await _httpClient.delete(
        uri,
        headers: headers ?? _getDefaultHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      throw ServerException();
    }
  }

  /// Xây dựng URI từ URL và query parameters
  Uri _buildUri(String url, Map<String, dynamic>? queryParameters) {
    // Kiểm tra xem URL có phải là URL đầy đủ không
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Uri.parse(url).replace(
        queryParameters: queryParameters?.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );
    }

    // Nếu không, coi đây là đường dẫn tương đối và thêm base URL
    final baseUrl = 'https://api.example.com'; // Thay đổi theo cấu hình thực tế
    return Uri.parse('$baseUrl$url').replace(
      queryParameters: queryParameters?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  /// Trả về headers mặc định cho request
  Map<String, String> _getDefaultHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Thêm các headers khác nếu cần, ví dụ: Authorization
    };
  }

  /// Xử lý response từ server
  ApiResponse _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody =
        response.body.isNotEmpty ? json.decode(response.body) : null;

    return ApiResponse(
      statusCode: statusCode,
      data: responseBody,
      headers: response.headers,
    );
  }
}

/// Lớp đại diện cho response từ API
class ApiResponse {
  final int statusCode;
  final dynamic data;
  final Map<String, String> headers;

  ApiResponse({
    required this.statusCode,
    required this.data,
    required this.headers,
  });

  /// Kiểm tra xem response có thành công không (status code 2xx)
  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

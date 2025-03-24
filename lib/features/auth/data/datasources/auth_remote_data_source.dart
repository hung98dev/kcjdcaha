import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/constants/api_constants.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/features/auth/data/models/user_model.dart';
import 'package:sync_ops/features/auth/data/datasources/auth_local_data_source.dart';

abstract class AuthRemoteDataSource {
  /// Đăng nhập với email và mật khẩu
  /// Throws [ServerException] nếu có lỗi từ server
  Future<UserModel> login(String email, String password);

  /// Đăng ký tài khoản mới
  /// Throws [ServerException] nếu có lỗi từ server
  Future<UserModel> register(String email, String password, String fullName);

  /// Đăng xuất
  /// Throws [ServerException] nếu có lỗi từ server
  Future<void> logout();

  /// Quên mật khẩu
  /// Throws [ServerException] nếu có lỗi từ server
  Future<void> forgotPassword(String email);

  /// Đổi mật khẩu
  /// Throws [ServerException] nếu có lỗi từ server
  Future<void> changePassword(String oldPassword, String newPassword);

  /// Làm mới token
  /// Throws [ServerException] nếu có lỗi từ server
  Future<UserModel> refreshToken(String token);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource localDataSource;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.localDataSource,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final userData = responseData['user'] ?? responseData;
      final token = responseData['token'] ?? '';
      final tokenExpiry =
          responseData['tokenExpiry'] != null
              ? DateTime.parse(responseData['tokenExpiry'])
              : DateTime.now().add(const Duration(days: 7)); // Mặc định 7 ngày

      // Tạo UserModel với token và thời gian hết hạn
      final userModel = UserModel.fromJson(userData);
      return userModel.copyWith(token: token, tokenExpiry: tokenExpiry);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register(
    String email,
    String password,
    String fullName,
  ) async {
    // Gửi request POST đến endpoint đăng ký
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      // Chuyển đổi thông tin đăng ký thành JSON
      body: json.encode({
        'email': email,
        'password': password,
        'fullName': fullName,
      }),
    );

    // Kiểm tra kết quả trả về từ server
    if (response.statusCode == 201) {
      // Chuyển đổi response thành đối tượng UserModel
      return UserModel.fromJson(json.decode(response.body));
    } else {
      // Ném exception nếu có lỗi
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    // Gửi request POST đến endpoint đăng xuất
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/logout'),
      headers: {'Content-Type': 'application/json'},
    );

    // Kiểm tra kết quả trả về từ server
    if (response.statusCode != 200) {
      // Ném exception nếu có lỗi
      throw ServerException();
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    // Gửi request POST đến endpoint quên mật khẩu
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      // Chuyển đổi email thành JSON
      body: json.encode({'email': email}),
    );

    // Kiểm tra kết quả trả về từ server
    if (response.statusCode != 200) {
      // Ném exception nếu có lỗi
      throw ServerException();
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    // Gửi request POST đến endpoint đổi mật khẩu
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/change-password'),
      headers: {'Content-Type': 'application/json'},
      // Chuyển đổi thông tin mật khẩu thành JSON
      body: json.encode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    // Kiểm tra kết quả trả về từ server
    if (response.statusCode != 200) {
      // Ném exception nếu có lỗi
      throw ServerException();
    }
  }

  @override
  Future<UserModel> refreshToken(String token) async {
    // Gửi request POST đến endpoint làm mới token
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/refresh-token'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Kiểm tra kết quả trả về từ server
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final userData = responseData['user'] ?? responseData;
      final newToken = responseData['token'] ?? '';
      final tokenExpiry =
          responseData['tokenExpiry'] != null
              ? DateTime.parse(responseData['tokenExpiry'])
              : DateTime.now().add(const Duration(days: 7)); // Mặc định 7 ngày

      // Tạo UserModel với token mới và thời gian hết hạn
      final userModel = UserModel.fromJson(userData);
      return userModel.copyWith(token: newToken, tokenExpiry: tokenExpiry);
    } else {
      throw ServerException();
    }
  }
}

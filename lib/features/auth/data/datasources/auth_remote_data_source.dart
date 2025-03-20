import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/constants/api_constants.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/features/auth/data/models/user_model.dart';

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
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
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
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'fullName': fullName,
      }),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/logout'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/auth/change-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}

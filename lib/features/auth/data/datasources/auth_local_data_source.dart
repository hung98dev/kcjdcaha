import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  /// Lấy thông tin người dùng đã lưu trong cache
  /// Throws [CacheException] nếu không có dữ liệu
  Future<UserModel?> getLastUser();

  /// Lưu thông tin người dùng vào cache
  Future<void> cacheUser(UserModel userToCache);

  /// Xóa thông tin người dùng khỏi cache
  Future<void> clearUser();
}

const CACHED_USER_KEY = 'CACHED_USER';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getLastUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER_KEY);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }

  @override
  Future<void> cacheUser(UserModel userToCache) async {
    await sharedPreferences.setString(
      CACHED_USER_KEY,
      json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove(CACHED_USER_KEY);
  }
}

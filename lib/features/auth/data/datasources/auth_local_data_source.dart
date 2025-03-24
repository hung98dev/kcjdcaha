import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_ops/core/errors/exceptions.dart';
import 'package:sync_ops/features/auth/data/models/user_model.dart';

/// Interface định nghĩa các phương thức để thao tác với dữ liệu người dùng trong bộ nhớ cục bộ
abstract class AuthLocalDataSource {
  /// Lấy thông tin người dùng đã lưu trong cache
  /// Trả về [UserModel] nếu có dữ liệu trong cache
  /// Trả về null nếu không có dữ liệu
  /// Throws [CacheException] nếu có lỗi khi đọc dữ liệu từ cache
  Future<UserModel?> getLastUser();

  /// Lưu thông tin người dùng vào cache
  /// [userToCache] là đối tượng [UserModel] cần lưu
  /// Throws [CacheException] nếu có lỗi khi lưu dữ liệu
  Future<void> cacheUser(UserModel userToCache);

  /// Xóa thông tin người dùng khỏi cache
  /// Throws [CacheException] nếu có lỗi khi xóa dữ liệu
  Future<void> clearUser();

  /// Kiểm tra token có hợp lệ không dựa vào thời gian hết hạn
  /// Trả về true nếu token còn hợp lệ, false nếu token đã hết hạn hoặc không tồn tại
  Future<bool> isTokenValid();
}

/// Key để lưu thông tin người dùng trong SharedPreferences
const CACHED_USER_KEY = 'CACHED_USER';

/// Implement của [AuthLocalDataSource] sử dụng [SharedPreferences] để lưu trữ dữ liệu
@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  /// Instance của [SharedPreferences] để thao tác với bộ nhớ cục bộ
  final SharedPreferences sharedPreferences;

  /// Constructor nhận vào instance [SharedPreferences]
  /// được inject bởi dependency injection
  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getLastUser() async {
    // Lấy chuỗi JSON từ SharedPreferences
    final jsonString = sharedPreferences.getString(CACHED_USER_KEY);
    if (jsonString != null) {
      // Chuyển đổi chuỗi JSON thành đối tượng UserModel
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      // Trả về null nếu không có dữ liệu
      return null;
    }
  }

  @override
  Future<void> cacheUser(UserModel userToCache) async {
    // Chuyển đổi đối tượng UserModel thành chuỗi JSON
    // và lưu vào SharedPreferences
    await sharedPreferences.setString(
      CACHED_USER_KEY,
      json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<void> clearUser() async {
    // Xóa dữ liệu người dùng khỏi SharedPreferences
    await sharedPreferences.remove(CACHED_USER_KEY);
  }

  @override
  Future<bool> isTokenValid() async {
    try {
      // Lấy thông tin người dùng từ SharedPreferences
      final user = await getLastUser();

      // Kiểm tra xem có token và thời gian hết hạn không
      if (user?.token == null || user?.tokenExpiry == null) {
        return false;
      }

      // Kiểm tra xem token đã hết hạn chưa
      final now = DateTime.now();
      return now.isBefore(user!.tokenExpiry!);
    } catch (e) {
      // Nếu có lỗi, coi như token không hợp lệ
      return false;
    }
  }
}

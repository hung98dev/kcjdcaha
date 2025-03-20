// Import package get_it để sử dụng Service Locator pattern
import 'package:get_it/get_it.dart';
// Import package http để thực hiện các HTTP request
import 'package:http/http.dart' as http;
// Import package injectable để sử dụng dependency injection
import 'package:injectable/injectable.dart';
// Import package kiểm tra kết nối internet
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// Import package shared_preferences để lưu trữ dữ liệu local
import 'package:shared_preferences/shared_preferences.dart';
// Import file cấu hình injection được tạo tự động
import 'package:sync_ops/app/di/injection.config.dart';

// Khởi tạo singleton instance của GetIt để quản lý dependencies
final getIt = GetIt.instance;

// Decorator @InjectableInit để cấu hình injectable
@InjectableInit(
  initializerName: 'init', // Tên hàm khởi tạo
  preferRelativeImports: true, // Sử dụng relative imports
  asExtension: false, // Không tạo extension method
)
// Hàm cấu hình các dependencies cho ứng dụng
Future<void> configureDependencies() async {
  // Đăng ký các dependencies từ thư viện bên thứ ba
  final sharedPreferences =
      await SharedPreferences.getInstance(); // Khởi tạo SharedPreferences instance
  getIt.registerLazySingleton(
    () => sharedPreferences,
  ); // Đăng ký SharedPreferences như một lazy singleton
  getIt.registerLazySingleton(
    () => http.Client(),
  ); // Đăng ký HTTP Client như một lazy singleton
  getIt.registerLazySingleton(
    () => InternetConnection(),
  ); // Đăng ký InternetConnection như một lazy singleton

  // Khởi tạo các dependencies được đăng ký bởi injectable
  init(getIt);
}

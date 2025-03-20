// Import thư viện injectable để hỗ trợ dependency injection
import 'package:injectable/injectable.dart';
// Import thư viện kiểm tra kết nối internet
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Định nghĩa interface NetworkInfo với một phương thức getter isConnected
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// Đánh dấu class này có thể inject được và implement interface NetworkInfo
@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  // Khai báo biến connectionChecker kiểu InternetConnection
  final InternetConnection connectionChecker;

  // Constructor nhận tham số connectionChecker
  NetworkInfoImpl(this.connectionChecker);

  // Override phương thức isConnected từ interface NetworkInfo
  // Trả về kết quả kiểm tra kết nối internet từ connectionChecker
  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}

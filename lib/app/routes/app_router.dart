// Import các package cần thiết
import 'package:flutter/material.dart'; // Package chính của Flutter
import 'package:go_router/go_router.dart'; // Package điều hướng
import 'package:injectable/injectable.dart'; // Package hỗ trợ dependency injection
import 'package:sync_ops/features/auth/domain/usecases/is_logged_in_usecase.dart'; // UseCase kiểm tra trạng thái đăng nhập
import 'package:sync_ops/features/auth/presentation/pages/login_page.dart'; // Trang đăng nhập
import 'package:sync_ops/features/auth/presentation/pages/register_page.dart'; // Trang đăng ký
import 'package:sync_ops/features/dashboard/presentation/pages/dashboard_page.dart'; // Trang dashboard

// Widget hiển thị màn hình loading
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hiển thị một màn hình loading đơn giản với CircularProgressIndicator ở giữa
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

// Class quản lý routing của ứng dụng
@injectable // Đánh dấu class có thể được inject bởi GetIt
class AppRouter {
  final IsLoggedInUseCase
  _isLoggedInUseCase; // UseCase để kiểm tra trạng thái đăng nhập

  // Constructor nhận vào IsLoggedInUseCase thông qua dependency injection
  AppRouter(this._isLoggedInUseCase);

  // Khởi tạo router với các cấu hình
  late final router = GoRouter(
    initialLocation: '/loading', // Route mặc định khi khởi động ứng dụng
    redirect:
        _handleRedirect, // Hàm xử lý redirect dựa trên trạng thái đăng nhập
    routes: [
      // Danh sách các route trong ứng dụng
      // Route màn hình loading
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingPage(),
      ),
      // Route màn hình đăng nhập (route mặc định)
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      // Route màn hình đăng ký
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      // Route màn hình dashboard
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );

  // Hàm xử lý redirect dựa trên trạng thái đăng nhập
  Future<String?> _handleRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Kiểm tra trạng thái đăng nhập
    final isLoggedIn = await _isLoggedInUseCase();
    // Kiểm tra xem route hiện tại có phải là route đăng nhập hoặc đăng ký không
    final isLoginRoute =
        state.matchedLocation == '/' || state.matchedLocation == '/register';

    // Nếu chưa đăng nhập và không ở route đăng nhập/đăng ký -> chuyển về trang đăng nhập
    if (!isLoggedIn && !isLoginRoute) {
      return '/';
    }
    // Nếu đã đăng nhập và đang ở route đăng nhập/đăng ký -> chuyển về dashboard
    else if (isLoggedIn && isLoginRoute) {
      return '/dashboard';
    }

    // Không cần redirect
    return null;
  }
}

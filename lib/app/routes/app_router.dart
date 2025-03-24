// Import các package cần thiết
import 'package:flutter/material.dart'; // Package chính của Flutter // Package chứa kDebugMode
import 'package:go_router/go_router.dart'; // Package điều hướng
import 'package:injectable/injectable.dart'; // Package hỗ trợ dependency injection
import 'package:sync_ops/features/auth/domain/usecases/is_logged_in_usecase.dart'; // UseCase kiểm tra trạng thái đăng nhập
import 'package:sync_ops/features/auth/domain/usecases/is_token_valid_usecase.dart'; // UseCase kiểm tra tính hợp lệ của token
import 'package:sync_ops/features/auth/presentation/pages/login_page.dart'; // Trang đăng nhập
import 'package:sync_ops/features/auth/presentation/pages/register_page.dart'; // Trang đăng ký
import 'package:sync_ops/features/dashboard/presentation/pages/dashboard_page.dart'; // Trang dashboard
import 'package:sync_ops/features/mes/presentation/pages/mes_home_page.dart'; // Trang chính của module MES

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
  final IsTokenValidUseCase _isTokenValidUseCase;
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  // Constructor nhận vào IsLoggedInUseCase và IsTokenValidUseCase thông qua dependency injection
  AppRouter(this._isTokenValidUseCase);

  // Khởi tạo router với các cấu hình
  late final router = GoRouter(
    initialLocation: '/loading', // Route mặc định khi khởi động ứng dụng
    navigatorKey: _rootNavigatorKey, // Sử dụng navigatorKey cho GoRouter
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
      // Route màn hình MES
      GoRoute(
        path: '/mes',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const MesHomePage(),
      ),
    ],
  );

  // Hàm xử lý redirect dựa trên trạng thái xác thực và tính hợp lệ của token
  Future<String?> _handleRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Kiểm tra tính hợp lệ của token
    final isTokenValid = await _isTokenValidUseCase();
    // Kiểm tra xem route hiện tại có phải là route đăng nhập hoặc đăng ký không
    final isLoginRoute =
        state.matchedLocation == '/loading' ||
        state.matchedLocation == '/' ||
        state.matchedLocation == '/register';

    // Nếu token không hợp lệ và không ở route đăng nhập/đăng ký -> chuyển về trang đăng nhập
    if (!isTokenValid && !isLoginRoute) {
      return '/';
    }
    // Nếu token hợp lệ và đang ở route đăng nhập/đăng ký -> chuyển về dashboard
    else if (isTokenValid && isLoginRoute) {
      return '/dashboard';
    }

    // Không cần redirect
    return null;
  }
}

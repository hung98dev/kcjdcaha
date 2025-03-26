// Import các package cần thiết cho ứng dụng
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Package quản lý state với BLoC pattern
import 'package:flutter_localizations/flutter_localizations.dart'; // Package hỗ trợ đa ngôn ngữ
import 'package:get_it/get_it.dart'; // Package dependency injection
import 'package:sync_ops/app/di/injection.dart'; // Cấu hình dependency injection
import 'package:sync_ops/app/routes/app_router.dart'; // Cấu hình routing
import 'package:sync_ops/app/theme/app_theme.dart'; // Theme của ứng dụng
import 'package:sync_ops/features/auth/presentation/bloc/auth_bloc.dart'; // BLoC xử lý authentication
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // File gen cho đa ngôn ngữ

// Khởi tạo singleton instance của GetIt để quản lý dependency injection
final GetIt getIt = GetIt.instance;

// Hàm main của ứng dụng
void main() async {
  // Đảm bảo Flutter bindings được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo dependency injection
  await configureDependencies();

  // Khởi tạo AuthBloc và kiểm tra trạng thái xác thực
  final authBloc = getIt<AuthBloc>();
  authBloc.add(const AuthEvent.checkAuthStatus());

  // Chạy ứng dụng với widget gốc là MyApp
  runApp(const MyApp());
}

// Widget gốc của ứng dụng
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy instance của AppRouter từ dependency injection
    final appRouter = getIt<AppRouter>();
    final authBloc = getIt<AuthBloc>();

    // Bọc ứng dụng trong BlocProvider.value để cung cấp AuthBloc cho toàn bộ ứng dụng
    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'SyncOps', // Tiêu đề của ứng dụng
        theme: AppTheme.lightTheme, // Theme sáng
        darkTheme: AppTheme.darkTheme, // Theme tối
        themeMode: ThemeMode.system, // Sử dụng theme theo cài đặt hệ thống
        routerConfig: appRouter.router, // Cấu hình routing
        // Cấu hình đa ngôn ngữ
        localizationsDelegates: const [
          AppLocalizations.delegate, // Delegate cho các chuỗi được localized
          GlobalMaterialLocalizations.delegate, // Delegate cho Material widgets
          GlobalWidgetsLocalizations.delegate, // Delegate cho basic widgets
          GlobalCupertinoLocalizations
              .delegate, // Delegate cho Cupertino widgets
        ],
        // Các ngôn ngữ được hỗ trợ
        supportedLocales: const [
          Locale('en'), // Tiếng Anh
          Locale('vi'), // Tiếng Việt
        ],
      ),
    );
  }
}

// Import các package cần thiết
import 'package:flutter/material.dart'; // Package chính của Flutter
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; // Package điều hướng
import 'package:sync_ops/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sync_ops/features/dashboard/presentation/widgets/feature_card.dart'; // Widget card tính năng

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Refresh quyền người dùng khi trang dashboard được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authBloc = BlocProvider.of<AuthBloc>(context);
      authBloc.add(const AuthEvent.refreshUserPermissionsRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng AuthBloc từ context, đây là instance được cung cấp từ BlocProvider trong MyApp
    // Không cần tạo instance mới từ GetIt
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SyncOps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authBloc.add(const AuthEvent.logoutRequested());
            },
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case Unauthenticated():
              context.go('/');
            default:
              break;
          }
        },
        builder: (context, state) {
          return switch (state) {
            Authenticated() => SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.dashboard_customize_outlined,
                    size: 60,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Chào mừng đến với SyncOps',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Hệ thống quản lý doanh nghiệp toàn diện',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return FeatureCard.crm(
                            onTap: () {
                              // TODO: Navigate to CRM module
                            },
                          );
                        case 1:
                          return FeatureCard.wms(
                            onTap: () {
                              // TODO: Navigate to WMS module
                            },
                          );
                        case 2:
                          return FeatureCard.mes(
                            onTap: () {
                              context.go('/mes');
                            },
                          );
                        case 3:
                          return FeatureCard.erp(
                            onTap: () {
                              // TODO: Navigate to ERP module
                            },
                          );
                        case 4:
                          return FeatureCard.admin(
                            onTap: () {
                              // TODO: Navigate to Admin module
                            },
                          );
                        case 5:
                          return FeatureCard.hrm(
                            onTap: () {
                              context.go('/hrm');
                            },
                          );
                          case 6:
                          return FeatureCard.acount(
                            onTap: () {
                              // TODO: Navigate to Admin module
                            },
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
            Loading() => const Center(child: CircularProgressIndicator()),
            Error(message: final message) => Center(
              child: Text('Lỗi: $message'),
            ),
            _ => const Center(child: Text('Vui lòng đăng nhập để tiếp tục')),
          };
        },
      ),
    );
  }
}

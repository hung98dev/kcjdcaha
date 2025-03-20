import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_ops/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sync_ops/features/dashboard/presentation/widgets/feature_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SyncOps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.go('/');
          }
        },
        child: SingleChildScrollView(
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
                style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center
              ),
              const SizedBox(height: 10),
              Text(
                'Hệ thống quản lý doanh nghiệp toàn diện',
                style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: 6,
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
                          // TODO: Navigate to MES module
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
      ),
    );
  }
}

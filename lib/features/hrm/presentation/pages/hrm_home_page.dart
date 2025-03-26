// Import các package cần thiết
import 'package:flutter/material.dart'; // Package BLoC
import 'package:get_it/get_it.dart'; // Package dependency injection
import 'package:go_router/go_router.dart'; // Package điều hướng
import 'package:sync_ops/features/hrm/presentation/pages/hrm_attendance_page.dart';
import 'package:sync_ops/features/hrm/presentation/pages/hrm_utilities_page.dart';
import 'package:sync_ops/features/hrm/presentation/pages/hrm_messages_page.dart';
import 'package:sync_ops/features/hrm/presentation/pages/hrm_notifications_page.dart';
import 'package:sync_ops/features/hrm/presentation/pages/hrm_profile_page.dart';

// Lấy instance của GetIt
final getIt = GetIt.instance;

/// Widget trang chính của module HRM với bottom navigation
class HrmHomePage extends StatefulWidget {
  const HrmHomePage({super.key});

  @override
  State<HrmHomePage> createState() => _HrmHomePageState();
}

class _HrmHomePageState extends State<HrmHomePage> {
  // Index của tab hiện tại
  int _currentIndex = 0;

  // Sử dụng AutomaticKeepAliveClientMixin để giữ trạng thái các trang
  // Danh sách các trang được khởi tạo khi cần (lazy loading)
  late final List<Widget> _pages = [
    _KeepAlivePage(child: const HrmAttendancePage()),
    _KeepAlivePage(child: const HrmUtilitiesPage()),
    _KeepAlivePage(child: const HrmMessagesPage()),
    _KeepAlivePage(child: const HrmNotificationsPage()),
    _KeepAlivePage(child: const HrmProfilePage()),
  ];

  // Cấu hình bottom navigation item - tách thành model riêng
  static const List<_NavItemConfig> _navConfigs = [
    _NavItemConfig(
      icon: Icons.access_time_outlined,
      activeIcon: Icons.access_time_filled,
    ),
    _NavItemConfig(icon: Icons.apps_outlined, activeIcon: Icons.apps),
    _NavItemConfig(icon: Icons.message_outlined, activeIcon: Icons.message),
    _NavItemConfig(
      icon: Icons.notifications_outlined,
      activeIcon: Icons.notifications,
    ),
    _NavItemConfig(icon: Icons.person_outline, activeIcon: Icons.person),
  ];

  // Cache bottom navigation items để tránh rebuild mỗi lần
  late final List<BottomNavigationBarItem> _bottomNavItems = _buildNavItems();

  List<BottomNavigationBarItem> _buildNavItems() {
    const double iconScale =
        1.2; // Tăng kích thước icon vì không hiển thị label

    return _navConfigs
        .map(
          (config) => BottomNavigationBarItem(
            icon: Transform.scale(scale: iconScale, child: Icon(config.icon)),
            activeIcon: Transform.scale(
              scale: iconScale,
              child: Icon(config.activeIcon),
            ),
            label: '', // Label rỗng (bắt buộc cho BottomNavigationBarItem)
          ),
        )
        .toList();
  }

  // Xử lý sự kiện khi tab được chọn - thêm debounce để tránh click nhanh liên tục
  bool _isProcessingTap = false;
  void _onNavItemTapped(int index) {
    if (_currentIndex != index && !_isProcessingTap) {
      _isProcessingTap = true;
      setState(() {
        _currentIndex = index;
      });
      // Thêm debounce nhỏ để ngăn tap liên tục
      Future.delayed(const Duration(milliseconds: 200), () {
        _isProcessingTap = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && context.mounted) {
          context.go('/dashboard');
        }
      },
      child: Scaffold(
        // Sử dụng IndexedStack để giữ trạng thái của tất cả các trang
        body: IndexedStack(index: _currentIndex, children: _pages),
        // Thay thành Theme để tùy chỉnh hiệu ứng splash
        bottomNavigationBar: Theme(
          // Chỉ ghi đè thuộc tính splashFactory và highlightColor của theme
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
            primaryColor: Colors.white,
            splashColor: Colors.white.withOpacity(0.1),
            highlightColor: Colors.transparent,
            splashFactory: InkSplash.splashFactory,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: theme.dividerColor, width: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onNavItemTapped,
              items: _bottomNavItems,
              type: BottomNavigationBarType.fixed,
              backgroundColor: theme.colorScheme.surface,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}

// Widget wrapper để giữ trạng thái trang khi chuyển tab
class _KeepAlivePage extends StatefulWidget {
  final Widget child;

  const _KeepAlivePage({required this.child});

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Giữ trạng thái trang

  @override
  Widget build(BuildContext context) {
    super.build(context); // Cần thiết cho AutomaticKeepAliveClientMixin
    return widget.child;
  }
}

// Class đơn giản hóa để cấu hình bottom navigation items
class _NavItemConfig {
  final IconData icon;
  final IconData activeIcon;

  const _NavItemConfig({required this.icon, required this.activeIcon});
}

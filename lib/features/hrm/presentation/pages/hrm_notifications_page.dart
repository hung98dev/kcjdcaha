import 'package:flutter/material.dart';

/// Trang Thông báo của module HRM
class HrmNotificationsPage extends StatelessWidget {
  const HrmNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo'), centerTitle: true),
      body: const Center(
        child: Text(
          'Trang đang được phát triển',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

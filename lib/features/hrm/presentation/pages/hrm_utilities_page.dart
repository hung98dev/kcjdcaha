import 'package:flutter/material.dart';

/// Trang Tiện ích của module HRM
class HrmUtilitiesPage extends StatelessWidget {
  const HrmUtilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tiện ích'), centerTitle: true),
      body: const Center(
        child: Text(
          'Trang đang được phát triển',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

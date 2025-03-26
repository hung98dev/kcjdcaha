import 'package:flutter/material.dart';

/// Trang Profile của module HRM
class HrmProfilePage extends StatelessWidget {
  const HrmProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ cá nhân'), centerTitle: true),
      body: const Center(
        child: Text(
          'Trang đang được phát triển',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

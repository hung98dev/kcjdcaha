import 'package:flutter/material.dart';

/// Trang Tin nhắn của module HRM
class HrmMessagesPage extends StatelessWidget {
  const HrmMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tin nhắn'), centerTitle: true),
      body: const Center(
        child: Text(
          'Trang đang được phát triển',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

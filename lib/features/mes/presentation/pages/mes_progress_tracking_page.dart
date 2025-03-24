// Import các package cần thiết
import 'package:flutter/material.dart';

/// Trang Theo dõi tiến độ của module MES
class MesProgressTrackingPage extends StatelessWidget {
  const MesProgressTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theo dõi tiến độ'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Trang Theo dõi tiến độ', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

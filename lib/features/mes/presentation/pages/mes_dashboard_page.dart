// Import các package cần thiết
import 'package:flutter/material.dart';

/// Trang Dashboard của module MES
class MesDashboardPage extends StatelessWidget {
  const MesDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MES Dashboard'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Trang Dashboard MES', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

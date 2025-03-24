// Import các package cần thiết
import 'package:flutter/material.dart';

/// Trang Quản lý nhân sự và thiết bị của module MES
class MesResourceManagementPage extends StatelessWidget {
  const MesResourceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý nhân sự & thiết bị'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Trang Quản lý nhân sự và thiết bị',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

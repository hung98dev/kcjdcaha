import 'package:flutter/material.dart';

/// Lớp AppTheme định nghĩa các theme cho ứng dụng
/// Bao gồm lightTheme cho chế độ sáng và darkTheme cho chế độ tối
class AppTheme {
  /// Theme cho chế độ sáng
  /// Sử dụng Material 3 với các cấu hình sau:
  /// - ColorScheme: Tạo từ màu blue làm seedColor
  /// - AppBarTheme: Căn giữa title và không có đổ bóng
  /// - ElevatedButtonTheme: Bo tròn góc 12px
  /// - CardTheme: Bo tròn góc 16px
  /// - InputDecorationTheme: Bo tròn góc 12px và padding 16px
  static final ThemeData lightTheme = ThemeData(
    // Sử dụng Material Design 3
    useMaterial3: true,
    // Tạo ColorScheme từ màu blue cho chế độ sáng
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    // Cấu hình AppBar với title ở giữa và không có đổ bóng
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    // Cấu hình style cho ElevatedButton với góc bo tròn 12px
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    // Cấu hình style cho Card với góc bo tròn 16px
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    // Cấu hình style cho Input với góc bo tròn 12px và padding 16px
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    ),
  );

  /// Theme cho chế độ tối
  /// Sử dụng Material 3 với các cấu hình tương tự lightTheme nhưng brightness là dark
  static final ThemeData darkTheme = ThemeData(
    // Sử dụng Material Design 3
    useMaterial3: true,
    // Tạo ColorScheme từ màu blue cho chế độ tối
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    // Cấu hình AppBar với title ở giữa và không có đổ bóng
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    // Cấu hình style cho ElevatedButton với góc bo tròn 12px
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    // Cấu hình style cho Card với góc bo tròn 16px
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    // Cấu hình style cho Input với góc bo tròn 12px và padding 16px
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Lớp bọc các chức năng quét mã QR/barcode từ thư viện mobile_scanner
/// Cung cấp giao diện đơn giản để quét và xử lý mã QR/barcode
class FlutterBarcodeScanner {
  /// Quét mã QR/barcode và trả về kết quả dưới dạng chuỗi
  /// Nếu quét thành công, trả về giá trị của mã
  /// Nếu người dùng hủy hoặc có lỗi, trả về '-1'
  ///
  /// [colorScanLine] - Màu của đường quét, định dạng hex (ví dụ: '#ff6666')
  /// [buttonText] - Văn bản hiển thị trên nút hủy (ví dụ: 'Hủy')
  /// [isShowFlashIcon] - Hiển thị nút bật/tắt đèn flash
  /// [scanMode] - Chế độ quét (hiện tại chỉ hỗ trợ BARCODE)
  static Future<String> scanBarcode(
    String colorScanLine,
    String buttonText,
    bool isShowFlashIcon,
    ScanMode scanMode,
  ) async {
    // Giá trị mặc định khi quét thất bại hoặc bị hủy
    String barcode = '-1';

    try {
      // Khởi tạo controller để điều khiển camera
      final MobileScannerController controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal, // Tốc độ quét bình thường
        facing: CameraFacing.back, // Sử dụng camera sau
        torchEnabled: false, // Mặc định tắt đèn flash
      );

      // Hiển thị dialog chứa camera để quét mã QR/barcode
      final result = await showDialog<String>(
        context:
            rootNavigatorKey.currentContext ??
            navigatorKey
                .currentContext!, // Sử dụng context từ GoRouter hoặc Navigator
        builder:
            (context) => AlertDialog(
              contentPadding: EdgeInsets.zero, // Loại bỏ padding mặc định
              content: SizedBox(
                width: 300, // Kích thước cố định cho dialog
                height: 300,
                child: Stack(
                  children: [
                    // Widget camera để quét mã
                    MobileScanner(
                      controller: controller,
                      onDetect: (capture) {
                        // Xử lý khi phát hiện mã QR/barcode
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          // Lấy giá trị của mã đầu tiên
                          final String? code = barcodes.first.rawValue;
                          if (code != null) {
                            // Đóng dialog và trả về giá trị mã
                            Navigator.pop(context, code);
                          }
                        }
                      },
                    ),
                    // Thanh điều khiển phía dưới
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Nút hủy quét
                          ElevatedButton(
                            onPressed:
                                () => Navigator.pop(
                                  context,
                                  '-1',
                                ), // Đóng dialog và trả về -1
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Màu nền đỏ
                              foregroundColor: Colors.white, // Màu chữ trắng
                            ),
                            child: Text(buttonText),
                          ),
                          // Nút bật/tắt đèn flash (hiển thị tùy theo isShowFlashIcon)
                          if (isShowFlashIcon)
                            IconButton(
                              icon: ValueListenableBuilder<bool>(
                                valueListenable: ValueNotifier<bool>(
                                  false,
                                ), // Theo dõi trạng thái đèn flash
                                builder: (context, enabled, child) {
                                  return Icon(
                                    enabled
                                        ? Icons.flash_on
                                        : Icons
                                            .flash_off, // Icon thay đổi theo trạng thái
                                    color: Colors.white,
                                  );
                                },
                              ),
                              onPressed: () async {
                                await controller
                                    .toggleTorch(); // Bật/tắt đèn flash
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );

      // Giải phóng tài nguyên camera
      controller.dispose();

      // Cập nhật kết quả nếu có
      if (result != null) {
        barcode = result;
      }
    } catch (e) {
      // Xử lý lỗi và trả về -1
      barcode = '-1';
    }

    return barcode;
  }
}

/// Chế độ quét mã QR/barcode
enum ScanMode { BARCODE }

/// GlobalKey để truy cập context từ bất kỳ đâu trong ứng dụng
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// GlobalKey để truy cập context từ GoRouter
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

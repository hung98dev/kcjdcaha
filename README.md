# SyncOps - Ứng dụng Quản lý Doanh nghiệp Toàn diện

## Giới thiệu

SyncOps là một ứng dụng quản lý doanh nghiệp toàn diện, tích hợp các chức năng MES (sản xuất), WMS (kho), ERP (tài chính & nhân sự), CRM (khách hàng) và Phản hồi khách hàng. Ứng dụng giúp doanh nghiệp tối ưu hóa sản xuất, kho vận, bán hàng, tài chính và chăm sóc khách hàng trên nền tảng di động.

## Chức năng chính

1. **Dashboard Tổng Quan**
   - Hiển thị biểu đồ, số liệu theo thời gian thực về sản xuất, kho, bán hàng, tài chính
   - Tùy chỉnh giao diện để hiển thị thông tin quan trọng nhất

2. **Quản lý sản xuất (MES)**
   - Theo dõi tiến độ sản xuất theo từng công đoạn
   - Quản lý máy móc, thiết bị, cảnh báo lỗi
   - Chấm công nhân viên, đánh giá hiệu suất

3. **Quản lý kho (WMS)**
   - Kiểm soát nhập – xuất kho, quét QR Code để kiểm tra tồn kho
   - Cảnh báo hàng sắp hết hoặc tồn kho lâu
   - Theo dõi vị trí hàng hóa trong kho

4. **Quản lý tài chính & nhân sự (ERP)**
   - Quản lý thu – chi, đơn hàng, hợp đồng
   - Theo dõi bảng lương, chấm công, KPI nhân viên
   - Xuất báo cáo doanh thu – chi phí theo thời gian thực

5. **Quản lý khách hàng (CRM)**
   - Danh sách khách hàng, lịch sử giao dịch, hợp đồng
   - Gửi báo giá, email, thông báo cho khách hàng ngay trên app
   - Hệ thống nhắc nhở chăm sóc khách hàng tự động

6. **Phản hồi khách hàng & Cải tiến**
   - Tiếp nhận và xử lý khiếu nại, phản hồi khách hàng
   - Phân tích dữ liệu phản hồi để tối ưu quy trình sản xuất và dịch vụ
   - Gửi khảo sát khách hàng tự động

## Cấu trúc thư mục

Dự án được tổ chức theo mô hình Clean Architecture với các tầng rõ ràng:

```
lib/
├── app/                      # Cấu hình ứng dụng
│   ├── di/                   # Dependency Injection
│   ├── routes/               # Định tuyến ứng dụng
│   ├── theme/                # Giao diện, theme
│   └── app.dart              # Entry point của ứng dụng
│
├── core/                     # Core functionality
│   ├── constants/            # Các hằng số
│   ├── errors/               # Xử lý lỗi
│   ├── network/              # Network handling
│   ├── storage/              # Local storage
│   └── utils/                # Tiện ích
│
├── data/                     # Data layer
│   ├── datasources/          # Data sources (local, remote)
│   ├── models/               # Data models
│   └── repositories/         # Repository implementations
│
├── domain/                   # Domain layer
│   ├── entities/             # Business entities
│   ├── repositories/         # Repository interfaces
│   └── usecases/             # Business logic
│
├── features/                 # Feature modules
│   ├── auth/                 # Authentication
│   ├── dashboard/            # Dashboard
│   ├── mes/                  # Manufacturing Execution System
│   ├── wms/                  # Warehouse Management System
│   ├── erp/                  # Enterprise Resource Planning
│   ├── crm/                  # Customer Relationship Management
│   └── feedback/             # Customer Feedback
│
├── l10n/                     # Localization
│   ├── app_en.arb            # English translations
│   └── app_vi.arb            # Vietnamese translations
│
└── main.dart                 # Entry point

assets/
├── fonts/                    # Custom fonts
├── icons/                    # App icons
├── images/                   # Images
│   ├── common/               # Common images
│   ├── dashboard/            # Dashboard images
│   ├── mes/                  # MES images
│   ├── wms/                  # WMS images
│   ├── erp/                  # ERP images
│   ├── crm/                  # CRM images
│   └── feedback/             # Feedback images
└── animations/               # Lottie animations
```

## Cài đặt và chạy

1. Cài đặt Flutter SDK: https://flutter.dev/docs/get-started/install
2. Clone repository
3. Cài đặt dependencies:
   ```
   flutter pub get
   ```
4. Chạy code generation:
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Chạy ứng dụng:
   ```
   flutter run
   ```

## Công nghệ sử dụng

- **State Management**: flutter_bloc
- **Dependency Injection**: get_it, injectable
- **Local Storage**: hive_ce, shared_preferences
- **Networking**: http
- **Routing**: go_router
- **UI Components**: flutter_svg, shimmer, carousel_slider
- **Localization**: flutter_localizations, intl
- **Code Generation**: freezed, json_serializable, build_runner

## Quy tắc phát triển

- Tuân thủ nguyên tắc SOLID
- Sử dụng Clean Architecture để phân tách các tầng
- Viết unit tests cho business logic
- Sử dụng BLoC pattern cho state management
- Đa ngôn ngữ với hỗ trợ tiếng Việt và tiếng Anh

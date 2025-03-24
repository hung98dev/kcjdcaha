// Import các package cần thiết
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_ops/core/utils/flutter_barcode_scanner.dart';
import 'package:sync_ops/features/mes/domain/entities/quality_control_order.dart';
import 'package:sync_ops/features/mes/presentation/bloc/quality_control_order/quality_control_order_bloc.dart';
// Không cần import quality_control_order_event.dart vì nó đã là part của quality_control_order_bloc.dart
// Không cần import quality_control_order_state.dart vì nó đã là part của quality_control_order_bloc.dart
import 'package:sync_ops/features/mes/presentation/widgets/quality_control_order_card.dart';

/// Trang Kiểm tra chất lượng của module MES
class MesQualityControlPage extends StatefulWidget {
  const MesQualityControlPage({super.key});

  @override
  State<MesQualityControlPage> createState() => _MesQualityControlPageState();
}

class _MesQualityControlPageState extends State<MesQualityControlPage> {
  // Controller cho thanh tìm kiếm
  final TextEditingController _searchController = TextEditingController();
  // Scroll controller để phát hiện khi cần tải thêm dữ liệu
  final ScrollController _scrollController = ScrollController();
  // Biến để kiểm soát trạng thái tìm kiếm
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Tải danh sách lệnh kiểm tra chất lượng ban đầu
    context.read<QualityControlOrderBloc>().add(
      const QualityControlOrderEvent.loadQualityControlOrders(),
    );

    // Thiết lập scroll listener để tải thêm dữ liệu khi cuộn đến 70%
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Xử lý sự kiện cuộn để tải thêm dữ liệu
  void _onScroll() {
    if (_isSearching) return; // Không tải thêm khi đang tìm kiếm

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Tải thêm khi cuộn đến 70% danh sách
    if (currentScroll >= maxScroll * 0.7) {
      final bloc = context.read<QualityControlOrderBloc>();
      final state = bloc.state;

      if (state is Loaded && !state.hasReachedMax) {
        bloc.add(const QualityControlOrderEvent.loadMoreQualityControlOrders());
      }
    }
  }

  // Xử lý sự kiện tìm kiếm
  void _onSearch(String keyword) {
    if (keyword.isEmpty) {
      _clearSearch();
      return;
    }

    setState(() {
      _isSearching = true;
    });

    context.read<QualityControlOrderBloc>().add(
      QualityControlOrderEvent.searchQualityControlOrders(keyword: keyword),
    );
  }

  // Xóa tìm kiếm và quay lại danh sách ban đầu
  void _clearSearch() {
    if (!_isSearching) return;

    _searchController.clear();
    setState(() {
      _isSearching = false;
    });

    context.read<QualityControlOrderBloc>().add(
      const QualityControlOrderEvent.clearQualityControlOrderSearch(),
    );
  }

  // Quét mã QR/barcode
  Future<void> _scanBarcode() async {
    try {
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Màu của nút hủy
        'Hủy', // Văn bản nút hủy
        true, // Hiển thị đèn flash
        ScanMode.BARCODE, // Chế độ quét
      );

      // Kiểm tra nếu người dùng hủy quét
      if (barcodeScanRes == '-1') return;

      // Cập nhật ô tìm kiếm và thực hiện tìm kiếm
      _searchController.text = barcodeScanRes;
      _onSearch(barcodeScanRes);
    } catch (e) {
      // Hiển thị thông báo lỗi nếu có
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi quét mã: $e')));
      }
    }
  }

  // Hiển thị chi tiết lệnh kiểm tra chất lượng
  void _showOrderDetails(QualityControlOrder order) {
    // TODO: Hiển thị chi tiết lệnh kiểm tra chất lượng trong một dialog hoặc chuyển đến trang chi tiết
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã chọn lệnh kiểm tra: ${order.id}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kiểm tra chất lượng'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm lệnh kiểm tra chất lượng...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Nút xóa tìm kiếm
                    if (_isSearching)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      ),
                    // Nút quét mã QR/barcode
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: _scanBarcode,
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: _onSearch,
              textInputAction: TextInputAction.search,
            ),
          ),

          // Danh sách lệnh kiểm tra chất lượng
          Expanded(
            child: BlocBuilder<
              QualityControlOrderBloc,
              QualityControlOrderState
            >(
              builder: (context, state) {
                // Trạng thái ban đầu hoặc đang tải
                if (state is Initial || (state is Loading && !_isSearching)) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Trạng thái đang tìm kiếm
                if (state is Searching) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Trạng thái lỗi
                if (state is Error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Đã xảy ra lỗi',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<QualityControlOrderBloc>().add(
                              const QualityControlOrderEvent.refreshQualityControlOrders(),
                            );
                          },
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  );
                }

                // Trạng thái kết quả tìm kiếm
                if (state is SearchResult) {
                  final orders = state.orders;
                  if (orders.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_off,
                            color: Colors.grey,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Không tìm thấy kết quả',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Không tìm thấy lệnh kiểm tra nào khớp với "${state.keyword}"',
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _clearSearch,
                            child: const Text('Quay lại danh sách'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return QualityControlOrderCard(
                        order: orders[index],
                        onTap: () => _showOrderDetails(orders[index]),
                      );
                    },
                  );
                }

                // Trạng thái đã tải dữ liệu
                if (state is Loaded) {
                  final orders = state.orders;
                  if (orders.isEmpty) {
                    return const Center(child: Text('Không có dữ liệu'));
                  }

                  // Hiển thị danh sách với RefreshIndicator để kéo xuống làm mới
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<QualityControlOrderBloc>().add(
                        const RefreshQualityControlOrders(),
                      );
                    },
                    child: Stack(
                      children: [
                        // Danh sách lệnh kiểm tra
                        ListView.builder(
                          controller: _scrollController,
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return QualityControlOrderCard(
                              order: orders[index],
                              onTap: () => _showOrderDetails(orders[index]),
                            );
                          },
                        ),

                        // Hiển thị loading indicator khi đang tải thêm
                        if (state is LoadingMore)
                          const Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  );
                }

                // Mặc định trả về container rỗng
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

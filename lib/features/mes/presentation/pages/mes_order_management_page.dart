// Import các package cần thiết
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sync_ops/core/utils/flutter_barcode_scanner.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';
import 'package:sync_ops/features/mes/presentation/bloc/production_order/production_order_bloc.dart';
import 'package:sync_ops/features/mes/presentation/bloc/production_order/production_order_event.dart';
import 'package:sync_ops/features/mes/presentation/bloc/production_order/production_order_state.dart';
import 'package:sync_ops/features/mes/presentation/widgets/production_order_card.dart';

/// Trang Quản lý lệnh sản xuất của module MES
class MesOrderManagementPage extends StatefulWidget {
  const MesOrderManagementPage({super.key});

  @override
  State<MesOrderManagementPage> createState() => _MesOrderManagementPageState();
}

class _MesOrderManagementPageState extends State<MesOrderManagementPage> {
  // Controller cho thanh tìm kiếm
  final TextEditingController _searchController = TextEditingController();
  // Scroll controller để phát hiện khi cần tải thêm dữ liệu
  final ScrollController _scrollController = ScrollController();
  // Biến để kiểm soát trạng thái tìm kiếm
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Tải danh sách lệnh sản xuất ban đầu
    context.read<ProductionOrderBloc>().add(const LoadProductionOrders());

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
      final bloc = context.read<ProductionOrderBloc>();
      final state = bloc.state;

      if (state is ProductionOrderLoaded && !state.hasReachedMax) {
        bloc.add(const LoadMoreProductionOrders());
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

    context.read<ProductionOrderBloc>().add(
      SearchProductionOrders(keyword: keyword),
    );
  }

  // Xóa tìm kiếm và quay lại danh sách ban đầu
  void _clearSearch() {
    if (!_isSearching) return;

    _searchController.clear();
    setState(() {
      _isSearching = false;
    });

    context.read<ProductionOrderBloc>().add(const ClearProductionOrderSearch());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý lệnh sản xuất'),
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
                hintText: 'Tìm kiếm lệnh sản xuất...',
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

          // Danh sách lệnh sản xuất
          Expanded(
            child: BlocBuilder<ProductionOrderBloc, ProductionOrderState>(
              builder: (context, state) {
                // Trạng thái ban đầu hoặc đang tải
                if (state is ProductionOrderInitial ||
                    (state is ProductionOrderLoading && !_isSearching)) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Trạng thái đang tìm kiếm
                if (state is ProductionOrderSearching) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Trạng thái lỗi
                if (state is ProductionOrderError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Đã xảy ra lỗi',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed:
                              () => context.read<ProductionOrderBloc>().add(
                                const RefreshProductionOrders(),
                              ),
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  );
                }

                // Kết quả tìm kiếm
                if (state is ProductionOrderSearchResult) {
                  final orders = state.orders;

                  if (orders.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off, size: 64),
                          const SizedBox(height: 16),
                          Text(
                            'Không tìm thấy lệnh sản xuất',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text('Từ khóa: "${state.keyword}"'),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return ProductionOrderCard(
                        order: orders[index],
                        onTap: () => _showOrderDetails(orders[index]),
                      );
                    },
                  );
                }

                // Danh sách đã tải
                if (state is ProductionOrderLoaded) {
                  final orders = state.orders;

                  if (orders.isEmpty) {
                    return const Center(
                      child: Text('Không có lệnh sản xuất nào'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ProductionOrderBloc>().add(
                        const RefreshProductionOrders(),
                      );
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: orders.length + (state.hasReachedMax ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index >= orders.length) {
                          // Hiển thị loading indicator ở cuối danh sách
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return ProductionOrderCard(
                          order: orders[index],
                          onTap: () => _showOrderDetails(orders[index]),
                        );
                      },
                    ),
                  );
                }

                // Trạng thái đang tải thêm
                if (state is ProductionOrderLoadingMore) {
                  final orders = state.currentOrders;

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: orders.length + 1, // +1 cho loading indicator
                    itemBuilder: (context, index) {
                      if (index >= orders.length) {
                        // Hiển thị loading indicator ở cuối danh sách
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return ProductionOrderCard(
                        order: orders[index],
                        onTap: () => _showOrderDetails(orders[index]),
                      );
                    },
                  );
                }

                // Trạng thái mặc định (không nên xảy ra)
                return const Center(child: Text('Trạng thái không xác định'));
              },
            ),
          ),
        ],
      ),
    );
  }

  // Hiển thị chi tiết lệnh sản xuất
  void _showOrderDetails(ProductionOrder order) {
    // TODO: Hiển thị chi tiết lệnh sản xuất trong một dialog hoặc chuyển đến trang chi tiết
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã chọn lệnh sản xuất: ${order.id}')),
    );
  }
}

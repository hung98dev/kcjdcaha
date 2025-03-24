import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sync_ops/features/mes/domain/entities/production_order.dart';

/// Widget hiển thị thông tin lệnh sản xuất dạng card
class ProductionOrderCard extends StatelessWidget {
  final ProductionOrder order;
  final VoidCallback? onTap;

  const ProductionOrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Màu sắc dựa trên mức độ ưu tiên
    final priorityColor = _getPriorityColor(order.priority);

    // Màu sắc dựa trên tiến độ
    final progressColor = _getProgressColor(order.progressPercentage);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hàng đầu: Mức độ ưu tiên và Mã lệnh sản xuất
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Mức độ ưu tiên
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: priorityColor, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flag, size: 16, color: priorityColor),
                        const SizedBox(width: 4),
                        Text(
                          order.priority.displayName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: priorityColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mã lệnh sản xuất
                  Text(
                    'Mã: ${order.id}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Ghi chú (nếu có)
              if (order.note != null && order.note!.isNotEmpty) ...[
                Text(
                  'Ghi chú: ${order.note}',
                  style: theme.textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],

              // Số lượng
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Số lượng cần sản xuất: ${order.plannedQuantity}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    'Đã sản xuất: ${order.completedQuantity}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Tiến độ
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tiến độ:', style: theme.textTheme.bodyMedium),
                      Text(
                        '${order.progressPercentage.toStringAsFixed(1)}%',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: progressColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: order.progressPercentage / 100,
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Ngày tháng
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bắt đầu: ${dateFormat.format(order.plannedStartDate)}',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Kết thúc: ${dateFormat.format(order.plannedEndDate)}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm lấy màu dựa trên mức độ ưu tiên
  Color _getPriorityColor(PriorityLevel priority) {
    switch (priority) {
      case PriorityLevel.high:
        return Colors.red;
      case PriorityLevel.medium:
        return Colors.orange;
      case PriorityLevel.low:
        return Colors.green;
      }
  }

  // Hàm lấy màu dựa trên tiến độ
  Color _getProgressColor(double progress) {
    if (progress < 30) {
      return Colors.red;
    } else if (progress < 70) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}

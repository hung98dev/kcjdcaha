import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sync_ops/features/mes/domain/entities/quality_control_order.dart';

/// Widget hiển thị thông tin của một lệnh kiểm tra chất lượng
class QualityControlOrderCard extends StatelessWidget {
  final QualityControlOrder order;
  final VoidCallback? onTap;

  const QualityControlOrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Màu sắc dựa trên trạng thái
    Color statusColor;
    switch (order.status) {
      case QualityControlStatus.pending:
        statusColor = Colors.grey;
        break;
      case QualityControlStatus.inProgress:
        statusColor = Colors.blue;
        break;
      case QualityControlStatus.completed:
        statusColor = Colors.green;
        break;
    }

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
              // Dòng 1: Mã lệnh và trạng thái
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.id,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      order.status.toDisplayString(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dòng 2: Công đoạn kiểm tra
              Row(
                children: [
                  const Icon(Icons.category, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Công đoạn: ${order.stage.toDisplayString()}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Dòng 3: Số lượng kiểm tra
              Row(
                children: [
                  const Icon(Icons.inventory_2, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'Số lượng: ${order.inspectedQuantity}/${order.plannedQuantity}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Dòng 4: Số lượng đạt/lỗi
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Đạt/Lỗi: ${order.passedQuantity}/${order.failedQuantity}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Dòng 5: Hạn kiểm tra
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Hạn kiểm tra: ${dateFormat.format(order.deadline)}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dòng 6: Thanh tiến độ
              LinearProgressIndicator(
                value: order.progressPercentage / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              ),
              const SizedBox(height: 4),
              Text(
                'Tiến độ: ${order.progressPercentage.toStringAsFixed(1)}%',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

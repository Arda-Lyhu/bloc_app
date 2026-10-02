import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../domain/entities/order_entity.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final orders = [
      const OrderEntity(
        orderNumber: '№1947034',
        date: '05-12-2025',
        quantity: 3,
        totalAmount: 112.0,
        status: 'Delivered',
      ),
      const OrderEntity(
        orderNumber: '№1947032',
        date: '02-12-2025',
        quantity: 1,
        totalAmount: 35.0,
        status: 'Processing',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const AppText.h2('My Orders'),
      ),
      body: ResponsiveContainer(
        maxWidth: 800,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final order = orders[index];
            final isDelivered = order.status == 'Delivered';

            return Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.title(
                        order.orderNumber,
                        fontWeight: FontWeight.bold,
                      ),
                      AppText.caption(
                        order.date,
                        isMuted: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.body(
                        'Quantity: ${order.quantity}',
                        isMuted: true,
                      ),
                      AppText.subtitle(
                        'Total: ${AppFormatters.currency(order.totalAmount)}',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (isDelivered ? Colors.green : Colors.amber)
                              .withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: AppText.overline(
                          order.status.toUpperCase(),
                          color: isDelivered
                              ? Colors.green.shade700
                              : Colors.amber.shade800,
                        ),
                      ),
                      const AppText.caption(
                        'View Details >',
                        fontWeight: FontWeight.w600,
                        isPrimary: true,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/order_entity.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(order.orderNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(order.date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quantity: ${order.quantity}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    Text('Total: \$${order.totalAmount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    order.status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: order.status == 'Delivered' ? Colors.green : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

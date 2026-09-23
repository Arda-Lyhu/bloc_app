import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'Order Delivered', 'desc': 'Your order №1947034 has been delivered!', 'time': '2h ago'},
      {'title': 'Summer Sale is On!', 'desc': 'Get up to 50% discount on summer collection.', 'time': '1d ago'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.notifications, color: Colors.white, size: 20),
            ),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['desc']!),
            trailing: Text(item['time']!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          );
        },
      ),
    );
  }
}

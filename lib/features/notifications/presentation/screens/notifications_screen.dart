import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final notifications = [
      {
        'title': 'Order Delivered',
        'desc': 'Your order №1947034 has been delivered!',
        'time': '2h ago',
        'icon': Icons.local_shipping_outlined,
      },
      {
        'title': 'Summer Sale is On!',
        'desc': 'Get up to 50% discount on summer collection.',
        'time': '1d ago',
        'icon': Icons.local_offer_outlined,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const AppText.h2('Notifications'),
      ),
      body: ResponsiveContainer(
        maxWidth: 800,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
          itemBuilder: (context, index) {
            final item = notifications[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: colorScheme.onPrimaryContainer,
                  size: 20,
                ),
              ),
              title: AppText.subtitle(
                item['title'] as String,
                fontWeight: FontWeight.bold,
              ),
              subtitle: AppText.body(
                item['desc'] as String,
                isMuted: true,
              ),
              trailing: AppText.caption(
                item['time'] as String,
                isMuted: true,
              ),
              onTap: () => AppHaptics.selection(),
            );
          },
        ),
      ),
    );
  }
}

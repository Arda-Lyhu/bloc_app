import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categories = [
      {'name': 'Beauty', 'icon': Icons.spa_outlined},
      {'name': 'Fragrances', 'icon': Icons.bubble_chart_outlined},
      {'name': 'Furniture', 'icon': Icons.chair_outlined},
      {'name': 'Groceries', 'icon': Icons.local_grocery_store_outlined},
      {'name': 'Home Decoration', 'icon': Icons.home_outlined},
      {'name': 'Smartphones', 'icon': Icons.phone_android_outlined},
      {'name': 'Laptops', 'icon': Icons.laptop_chromebook_outlined},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const AppText.h2('Categories'),
      ),
      body: ResponsiveContainer(
        maxWidth: 800,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
          itemBuilder: (context, index) {
            final cat = categories[index];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  cat['icon'] as IconData,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              title: AppText.subtitle(
                cat['name'] as String,
                fontWeight: FontWeight.w600,
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              onTap: () => AppHaptics.selection(),
            );
          },
        ),
      ),
    );
  }
}

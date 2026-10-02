import 'package:flutter/material.dart';
import 'app_button.dart';
import 'app_text.dart';

/// A polished, reusable empty state component for lists, carts, search results, and favorites.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.message,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    this.iconColor,
  });

  final String title;
  final String? message;
  final String? subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = iconColor ?? theme.colorScheme.primary;
    final description = subtitle ?? message ?? '';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon in glowing circle
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: color,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            AppText.h2(
              title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 8),
              AppText.body(
                description,
                textAlign: TextAlign.center,
                isMuted: true,
                maxLines: 3,
              ),
            ],

            // Action Button
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 28),
              AppButton(
                width: 200,
                label: actionLabel!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

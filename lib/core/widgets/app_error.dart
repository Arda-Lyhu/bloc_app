import 'package:flutter/material.dart';
import 'app_button.dart';
import 'app_text.dart';

/// Reusable enterprise Error state view with retry action.
class AppError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String title;

  const AppError({
    super.key,
    required this.message,
    this.title = 'Something went wrong',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: 20),
            AppText.h3(
              title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppText.body(
              message,
              isMuted: true,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: 140,
                child: AppButton(
                  label: 'Retry',
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  height: 44,
                  onPressed: onRetry,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

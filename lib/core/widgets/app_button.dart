import 'package:flutter/material.dart';
import '../utils/app_haptics.dart';
import 'app_loader.dart';

/// A dynamic, reusable button component with:
/// - Built-in haptic feedback on press
/// - Smooth loading spinner with disabled state
/// - Optional leading icon
/// - Customizable styling (height, width, radius, background color)
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 52,
    this.width = double.infinity,
    this.icon,
    this.borderRadius = 12,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;
  final double width;
  final Widget? icon;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;

  void _handlePress() {
    if (isLoading || onPressed == null) return;
    AppHaptics.buttonPress();
    onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      width: width,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          elevation: 0,
        ),
        onPressed: isLoading ? null : _handlePress,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? AppLoader.small(
                  color: foregroundColor ?? theme.colorScheme.onPrimary,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

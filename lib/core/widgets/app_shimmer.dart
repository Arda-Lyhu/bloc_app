import 'package:flutter/material.dart';

/// A sleek, customizable shimmer skeleton loader for loading states in production apps.
class AppShimmer extends StatefulWidget {
  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
    this.shape = BoxShape.rectangle,
  });

  final double width;
  final double height;
  final double borderRadius;
  final BoxShape shape;

  /// Shimmer for a standard card container.
  static Widget card({double height = 220, double borderRadius = 12}) {
    return AppShimmer(
      width: double.infinity,
      height: height,
      borderRadius: borderRadius,
    );
  }

  /// Shimmer list with multiple placeholder rows.
  static Widget list({int count = 5, double itemHeight = 72}) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) => AppShimmer(
        width: double.infinity,
        height: itemHeight,
        borderRadius: 12,
      ),
    );
  }

  /// Shimmer responsive grid for product feeds.
  static Widget grid({int count = 6, double aspectRatio = 0.7}) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: count,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (_, __) => AppShimmer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 12,
      ),
    );
  }

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.rectangle
                ? BorderRadius.circular(widget.borderRadius)
                : null,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ].map((s) => s.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'app_shimmer.dart';

/// Reusable enterprise Network Image with smooth fade-in, skeleton shimmer, and fallback
class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.isCircle = false,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget imageWidget;
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      imageWidget = _buildFallback(colorScheme);
    } else {
      imageWidget = Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ??
              AppShimmer(
                width: width ?? double.infinity,
                height: height ?? double.infinity,
              );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildFallback(colorScheme);
        },
      );
    }

    if (isCircle) {
      return ClipOval(
        child: SizedBox(
          width: width,
          height: height ?? width,
          child: imageWidget,
        ),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildFallback(ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: (width != null && width! < 40) ? 18 : 28,
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

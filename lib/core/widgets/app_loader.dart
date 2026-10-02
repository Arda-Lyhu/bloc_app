import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// Available animation styles for [AppLoader]
enum AppLoaderStyle {
  /// Fluid staggered wave of bouncing dots
  staggeredDots,

  /// Sleek rhythmic wave bar animation
  wave,

  /// Radial pulsing glow
  pulse,

  /// 3D geometric folding cube
  cubeGrid,

  /// Compact bouncing triple dots (great for buttons)
  threeBounce,

  /// High-tech cyber spinning lines
  spinningLines,

  /// Dual concentric expanding ripples
  doubleBounce,

  /// Rotating 3D folding cubes
  foldingCube,
}

/// Ultra-modern, cool animation loader system for production apps.
class AppLoader extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;
  final AppLoaderStyle style;
  final bool showCard;

  const AppLoader({
    super.key,
    this.message,
    this.size = 40.0,
    this.color,
    this.style = AppLoaderStyle.staggeredDots,
    this.showCard = false,
  });

  /// Small compact loader for buttons, chips, list tile trailing widgets
  const AppLoader.small({
    super.key,
    this.color,
    this.style = AppLoaderStyle.threeBounce,
  })  : size = 22.0,
        message = null,
        showCard = false;

  /// High-tech cyber wave loader
  const AppLoader.wave({
    super.key,
    this.message,
    this.size = 38.0,
    this.color,
    this.showCard = false,
  }) : style = AppLoaderStyle.wave;

  /// 3D Isometric Cube loader
  const AppLoader.cube({
    super.key,
    this.message,
    this.size = 42.0,
    this.color,
    this.showCard = false,
  }) : style = AppLoaderStyle.cubeGrid;

  /// Full-screen or large loader with elevated frosted card
  const AppLoader.fullScreen({
    super.key,
    this.message = 'Please wait...',
    this.color,
    this.style = AppLoaderStyle.staggeredDots,
  })  : size = 48.0,
        showCard = true;

  /// Shows a modal, blocking loading dialog with frosted glass effect
  static void showOverlay(
    BuildContext context, {
    String message = 'Loading...',
    AppLoaderStyle style = AppLoaderStyle.staggeredDots,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (ctx) => PopScope(
        canPop: false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: AppLoader.fullScreen(message: message, style: style),
          ),
        ),
      ),
    );
  }

  /// Closes the modal loading overlay if open
  static void hide(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor = color ?? theme.colorScheme.primary;

    final animationWidget = _buildAnimation(indicatorColor);

    if (showCard) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: indicatorColor.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              animationWidget,
              if (message != null && message!.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      );
    }

    if (message != null && message!.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animationWidget,
            const SizedBox(height: 16),
            Text(
              message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Center(child: animationWidget);
  }

  Widget _buildAnimation(Color color) {
    switch (style) {
      case AppLoaderStyle.staggeredDots:
        return LoadingAnimationWidget.staggeredDotsWave(
          color: color,
          size: size,
        );
      case AppLoaderStyle.wave:
        return SpinKitWave(
          color: color,
          size: size,
          type: SpinKitWaveType.center,
        );
      case AppLoaderStyle.pulse:
        return SpinKitPulse(
          color: color,
          size: size,
        );
      case AppLoaderStyle.cubeGrid:
        return SpinKitCubeGrid(
          color: color,
          size: size,
        );
      case AppLoaderStyle.threeBounce:
        return SpinKitThreeBounce(
          color: color,
          size: size,
        );
      case AppLoaderStyle.spinningLines:
        return SpinKitSpinningLines(
          color: color,
          size: size,
          itemCount: 4,
        );
      case AppLoaderStyle.doubleBounce:
        return SpinKitDoubleBounce(
          color: color,
          size: size,
        );
      case AppLoaderStyle.foldingCube:
        return SpinKitFoldingCube(
          color: color,
          size: size,
        );
    }
  }
}

/// A wrapper widget that dims, blurs, and displays an animated [AppLoader] over any child when [isLoading] is true.
class AppLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final AppLoaderStyle style;
  final double blur;

  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.style = AppLoaderStyle.staggeredDots,
    this.blur = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: AppLoader.fullScreen(
                      message: message ?? 'Loading...',
                      style: style,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// Screen size breakpoints for adaptive & responsive layouts across Mobile, Tablet, and Desktop/Web.
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
}

/// Adaptive layout builder that renders the appropriate UI depending on screen width.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Widget for phone screen widths (< 600px).
  final Widget mobile;

  /// Optional widget for tablet screens (600px - 1024px).
  final Widget? tablet;

  /// Optional widget for desktop/web screens (> 1024px).
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= AppBreakpoints.tablet && desktop != null) {
      return desktop!;
    }
    if (width >= AppBreakpoints.mobile && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

/// A responsive wrapper that centers and clamps content width on large screens / tablets.
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 1200,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}

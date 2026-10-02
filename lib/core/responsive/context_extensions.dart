import 'package:flutter/material.dart';
import 'responsive_layout.dart';

/// Extension methods on [BuildContext] for rapid, clean, and concise UI code.
extension BuildContextExtensions on BuildContext {
  // ─── Screen Dimensions ───────────────────────────────────────────────────
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  // ─── Responsive Queries ──────────────────────────────────────────────────
  bool get isMobile => screenWidth < AppBreakpoints.mobile;
  bool get isTablet =>
      screenWidth >= AppBreakpoints.mobile && screenWidth < AppBreakpoints.tablet;
  bool get isDesktop => screenWidth >= AppBreakpoints.tablet;

  // ─── Dynamic Responsive Grid Columns ────────────────────────────────────
  int get responsiveGridColumns {
    if (screenWidth >= AppBreakpoints.desktop) return 4;
    if (screenWidth >= AppBreakpoints.tablet) return 3;
    if (screenWidth >= AppBreakpoints.mobile) return 2;
    return 2;
  }

  // ─── Theme & Colors ──────────────────────────────────────────────────────
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // ─── Keyboard Focus ──────────────────────────────────────────────────────
  void unfocus() => FocusScope.of(this).unfocus();
}

import 'package:flutter/material.dart';

/// Reusable layout constants and standard dimensions.
class AppSpacing {
  AppSpacing._();

  // Padding & Gaps
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Border Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Max content width for responsive web / tablet
  static const double maxFormWidth = 420.0;
  static const double maxContentWidth = 1200.0;

  // Standard EdgeInsets helpers
  static const EdgeInsets paddingPage = EdgeInsets.all(md);
  static const EdgeInsets paddingForm = EdgeInsets.symmetric(horizontal: lg, vertical: xl);
  static const EdgeInsets paddingCard = EdgeInsets.all(md);
}

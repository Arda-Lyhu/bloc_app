import 'package:flutter/material.dart';

/// Centralized design typography tokens for the application.
/// Provides consistent, readable font styles with chaining extension helpers.
class AppTextStyle {
  AppTextStyle._();

  // ─── Base Typography Styles ──────────────────────────────────────────────

  /// Large Screen Display / Hero Title (32px, Bold)
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );

  /// Section Header / Big Title (24px, Bold)
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  /// Card / Modal / Sheet Title (20px, Semi-Bold)
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.35,
  );

  /// Prominent Title (18px, Semi-Bold)
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// List Item / Subtitle (16px, Medium)
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  /// Standard Body Text (14px, Regular)
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Emphasized Body Text (14px, Medium)
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  /// Small Supporting / Timestamp Text (12px, Regular)
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Small Badges / Tags (10px, Bold, Uppercase spacing)
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    height: 1.4,
  );

  /// Button Text (15px, Semi-Bold)
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );
}

/// Fluent chaining extensions on [TextStyle] for effortless in-line customizations.
///
/// Example:
/// ```dart
/// AppTextStyle.h1.bold.withColor(Colors.blue)
/// AppTextStyle.body.muted(context).italic
/// ```
extension AppTextStyleExtensions on TextStyle {
  // ─── Font Weights ────────────────────────────────────────────────────────
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  // ─── Font Styles & Decorations ───────────────────────────────────────────
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  // ─── Sizing & Spacing ───────────────────────────────────────────────────
  TextStyle size(double fontSize) => copyWith(fontSize: fontSize);
  TextStyle withHeight(double height) => copyWith(height: height);
  TextStyle letterSpacing(double spacing) => copyWith(letterSpacing: spacing);

  // ─── Colors ─────────────────────────────────────────────────────────────
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withOpacity(double opacity) =>
      copyWith(color: color?.withValues(alpha: opacity));

  /// Uses the theme's primary color
  TextStyle primary(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.primary);

  /// Uses the theme's secondary / muted text color
  TextStyle muted(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);

  /// Uses the theme's error color
  TextStyle error(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.error);

  /// Uses the theme's default onSurface text color
  TextStyle onSurface(BuildContext context) =>
      copyWith(color: Theme.of(context).colorScheme.onSurface);
}

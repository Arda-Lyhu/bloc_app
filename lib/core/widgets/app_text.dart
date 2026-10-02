import 'package:flutter/material.dart';
import '../constants/app_text_style.dart';

/// Clean, expressive declarative Text widget with preset styles and inline customization.
///
/// Example:
/// ```dart
/// AppText.h1('Welcome to Shop')
/// AppText.body('Item description...', isMuted: true, maxLines: 2)
/// AppText.title('Special Offer', isPrimary: true, fontWeight: FontWeight.bold)
/// ```
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool isPrimary;
  final bool isMuted;
  final bool isError;
  final bool isUnderline;
  final VoidCallback? onTap;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  });

  /// Hero Display Title (32px, Bold)
  const AppText.h1(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.h1;

  /// Section Header Title (24px, Bold)
  const AppText.h2(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.h2;

  /// Card / Section Header (20px, Semi-Bold)
  const AppText.h3(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.h3;

  /// Prominent Title (18px, Semi-Bold)
  const AppText.title(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.title;

  /// List Item / Subtitle (16px, Medium)
  const AppText.subtitle(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.subtitle;

  /// Standard Body Text (14px, Regular)
  const AppText.body(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.body;

  /// Small Supporting / Timestamp (12px, Regular)
  const AppText.caption(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.caption;

  /// Badge / Overline Tag (10px, Bold, Tracking)
  const AppText.overline(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isPrimary = false,
    this.isMuted = false,
    this.isError = false,
    this.isUnderline = false,
    this.onTap,
  }) : style = AppTextStyle.overline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Resolve base style or fallback to body
    TextStyle resolvedStyle = style ?? AppTextStyle.body;

    // Apply color logic
    Color? finalColor = color;
    if (finalColor == null) {
      if (isPrimary) {
        finalColor = colorScheme.primary;
      } else if (isMuted) {
        finalColor = colorScheme.onSurfaceVariant;
      } else if (isError) {
        finalColor = colorScheme.error;
      }
    }

    resolvedStyle = resolvedStyle.copyWith(
      color: finalColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
      decoration: isUnderline ? TextDecoration.underline : null,
    );

    final textWidget = Text(
      text,
      style: resolvedStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: textWidget,
      );
    }

    return textWidget;
  }
}

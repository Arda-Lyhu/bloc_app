import 'package:flutter/material.dart';
import '../utils/app_haptics.dart';

/// A modern, reusable text field with built-in support for:
/// - Tactile vibration feedback on password toggle & validation errors
/// - Password visibility toggle (`isPassword: true`)
/// - Dynamic prefix / suffix icons (`Widget` or `IconData`)
/// - Labels, hints, and helper texts
/// - Custom validation & input actions
/// - Consistent Material 3 styled border & focus states
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.labelText,
    this.hint,
    this.hintText,
    this.helperText,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.vibrateOnError = true,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.autovalidateMode,
    this.enabled = true,
    this.focusNode,
    this.maxLines = 1,
  });

  final String? label;
  final String? labelText;
  final String? hint;
  final String? hintText;
  final String? helperText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final bool vibrateOnError;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final bool enabled;
  final FocusNode? focusNode;
  final int maxLines;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  String? _handleValidation(String? value) {
    if (widget.validator == null) return null;
    final error = widget.validator!(value);
    // Vibrate when transitioning into an error state
    if (error != null && error != _lastError && widget.vibrateOnError) {
      AppHaptics.error();
    }
    _lastError = error;
    return error;
  }

  void _togglePasswordVisibility() {
    AppHaptics.selection();
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleFieldSubmitted(String value) {
    AppHaptics.buttonPress();
    widget.onFieldSubmitted?.call(value);
  }

  Widget? _buildIcon(dynamic icon, ThemeData theme) {
    if (icon == null) return null;
    if (icon is Widget) return icon;
    if (icon is IconData) {
      return Icon(icon, color: theme.colorScheme.onSurfaceVariant);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? effectiveSuffix;
    if (widget.isPassword) {
      effectiveSuffix = IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        tooltip: _obscureText ? 'Show password' : 'Hide password',
        onPressed: _togglePasswordVisibility,
      );
    } else {
      effectiveSuffix = _buildIcon(widget.suffixIcon, theme);
    }

    final effectivePrefix = _buildIcon(widget.prefixIcon, theme);
    final effectiveLabel = widget.label ?? widget.labelText;
    final effectiveHint = widget.hint ?? widget.hintText;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: _handleValidation,
      autovalidateMode: widget.autovalidateMode,
      onFieldSubmitted:
          widget.onFieldSubmitted != null ? _handleFieldSubmitted : null,
      onChanged: widget.onChanged,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      decoration: InputDecoration(
        labelText: effectiveLabel,
        hintText: effectiveHint,
        helperText: widget.helperText,
        prefixIcon: effectivePrefix,
        suffixIcon: effectiveSuffix,
        filled: true,
        fillColor:
            theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}

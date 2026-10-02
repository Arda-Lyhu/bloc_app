import 'package:flutter/material.dart';
import 'app_language.dart';
import 'app_translations.dart';
import 'language_controller.dart';

/// Extension on [BuildContext] for effortless translation access.
extension LocalizationExtensions on BuildContext {
  /// Translates a key according to the active language
  /// Example: `context.tr('home')` -> `"Home"` or `"ទំព័រដើម"`
  String tr(String key) {
    return AppTranslations.get(key, LanguageController.instance.language);
  }

  /// The active application language
  AppLanguage get language => LanguageController.instance.language;

  /// Returns true if Khmer language is active
  bool get isKhmer => LanguageController.instance.isKhmer;
}

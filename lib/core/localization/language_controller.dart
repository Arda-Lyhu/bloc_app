import 'package:flutter/material.dart';
import '../utils/app_haptics.dart';
import 'app_language.dart';
import 'app_translations.dart';

/// Reactive language manager for the entire application.
class LanguageController {
  LanguageController._();

  static final LanguageController instance = LanguageController._();

  /// Reactive notifier for the currently active language
  final ValueNotifier<AppLanguage> currentLanguage =
      ValueNotifier<AppLanguage>(AppLanguage.english);

  AppLanguage get language => currentLanguage.value;
  bool get isKhmer => currentLanguage.value == AppLanguage.khmer;

  /// Changes the application language dynamically
  void setLanguage(AppLanguage newLanguage) {
    if (currentLanguage.value == newLanguage) return;
    AppHaptics.selection();
    currentLanguage.value = newLanguage;
  }

  /// Helper translation method
  String tr(String key) => AppTranslations.get(key, currentLanguage.value);
}

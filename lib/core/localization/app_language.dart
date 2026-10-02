import 'package:flutter/material.dart';

/// Supported application languages.
enum AppLanguage {
  english(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    flagEmoji: '🇺🇸',
    locale: Locale('en', 'US'),
  ),
  khmer(
    code: 'km',
    name: 'Khmer',
    nativeName: 'ភាសាខ្មែរ',
    flagEmoji: '🇰🇭',
    locale: Locale('km', 'KH'),
  );

  const AppLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flagEmoji,
    required this.locale,
  });

  final String code;
  final String name;
  final String nativeName;
  final String flagEmoji;
  final Locale locale;

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code.toLowerCase() == code.toLowerCase(),
      orElse: () => AppLanguage.english,
    );
  }
}

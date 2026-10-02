import 'package:flutter/material.dart';
import '../localization/app_language.dart';
import '../localization/language_controller.dart';
import '../localization/localization_extensions.dart';
import 'app_dialogs.dart';
import 'app_text.dart';

/// Modal bottom sheet for choosing between English and Khmer
class LanguageSelectorSheet extends StatelessWidget {
  const LanguageSelectorSheet({super.key});

  /// Convenient helper to open the language sheet
  static Future<void> show(BuildContext context) {
    return AppDialogs.showBottomSheet(
      context: context,
      builder: (ctx) => const LanguageSelectorSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentLang = context.language;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h3(
                context.tr('changeLanguage'),
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...AppLanguage.values.map((lang) {
            final isSelected = lang == currentLang;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primaryContainer.withValues(alpha: 0.3)
                    : colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.outlineVariant.withValues(alpha: 0.4),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: Text(
                  lang.flagEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
                title: AppText.subtitle(
                  lang.nativeName,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: AppText.caption(
                  lang.name,
                  isMuted: true,
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: colorScheme.primary,
                        size: 24,
                      )
                    : null,
                onTap: () {
                  LanguageController.instance.setLanguage(lang);
                  Navigator.pop(context);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

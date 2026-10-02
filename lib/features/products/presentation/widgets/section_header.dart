import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.h1(title),
              const SizedBox(height: 2),
              AppText.caption(subtitle, isMuted: true),
            ],
          ),
          if (onViewAll != null)
            GestureDetector(
              onTap: () {
                AppHaptics.selection();
                onViewAll?.call();
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: AppText.caption(
                  'View all',
                  fontWeight: FontWeight.w600,
                  isPrimary: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

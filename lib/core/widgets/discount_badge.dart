import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

enum BadgeType { sale, isNew }

class DiscountBadge extends StatelessWidget {
  final String text;
  final BadgeType type;

  const DiscountBadge({
    super.key,
    required this.text,
    this.type = BadgeType.sale,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = type == BadgeType.sale ? AppColors.discountRed : AppColors.newBlack;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

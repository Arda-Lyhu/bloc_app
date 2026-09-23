import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class PriceTag extends StatelessWidget {
  final double price;
  final double? oldPrice;

  const PriceTag({
    super.key,
    required this.price,
    this.oldPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (oldPrice != null && oldPrice! > price) ...[
          Text(
            '${oldPrice!.toStringAsFixed(0)}\$',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${price.toStringAsFixed(0)}\$',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else ...[
          Text(
            '${price.toStringAsFixed(0)}\$',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

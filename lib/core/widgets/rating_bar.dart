import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final int count;

  const RatingBar({
    super.key,
    required this.rating,
    this.count = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            final starValue = index + 1;
            return Icon(
              rating >= starValue
                  ? Icons.star_rounded
                  : (rating >= starValue - 0.5
                      ? Icons.star_half_rounded
                      : Icons.star_outline_rounded),
              size: 14,
              color: AppColors.starYellow,
            );
          }),
        ),
        const SizedBox(width: 4),
        Text(
          '($count)',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

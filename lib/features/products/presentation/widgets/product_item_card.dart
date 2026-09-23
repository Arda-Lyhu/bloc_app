import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/discount_badge.dart';
import '../../../../core/widgets/price_tag.dart';
import '../../../../core/widgets/rating_bar.dart';
import '../../domain/entities/product.dart';

class ProductItemCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductItemCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  late bool isFav;

  @override
  void initState() {
    super.initState();
    isFav = widget.product.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final hasDiscount = product.discountPercentage > 0;
    final discountText = '-${product.discountPercentage.toStringAsFixed(0)}%';

    return SizedBox(
      width: 150,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 180,
                    width: 150,
                    color: Colors.grey[200],
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  ),
                ),
                // Badge (-20% or NEW)
                Positioned(
                  top: 8,
                  left: 8,
                  child: product.isNew && !hasDiscount
                      ? const DiscountBadge(text: 'NEW', type: BadgeType.isNew)
                      : (hasDiscount
                          ? DiscountBadge(
                              text: discountText, type: BadgeType.sale)
                          : const SizedBox.shrink()),
                ),
                // Circular White Floating Heart Icon
                Positioned(
                  bottom: -4,
                  right: 0,
                  child: Material(
                    elevation: 3,
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFav ? AppColors.primary : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Rating Stars
            RatingBar(
              rating: product.rating,
              count: product.ratingCount,
            ),
            const SizedBox(height: 4),

            // Brand Sub-label
            Text(
              product.brand,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),

            // Product Title
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

            // Price Tag
            PriceTag(
              price: product.price,
              oldPrice: hasDiscount ? product.oldPrice : null,
            ),
          ],
        ),
      ),
    );
  }
}

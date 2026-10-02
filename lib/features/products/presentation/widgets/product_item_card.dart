import 'package:flutter/material.dart';
import '../../../../core/core.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final product = widget.product;
    final hasDiscount = product.discountPercentage > 0;
    final discountText = '-${product.discountPercentage.toStringAsFixed(0)}%';

    return SizedBox(
      width: 150,
      child: GestureDetector(
        onTap: () {
          AppHaptics.selection();
          widget.onTap();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack
            Stack(
              clipBehavior: Clip.none,
              children: [
                AppNetworkImage(
                  imageUrl: product.thumbnail,
                  width: 150,
                  height: 180,
                  borderRadius: BorderRadius.circular(16),
                ),
                // Badge (-20% or NEW)
                if (product.isNew && !hasDiscount)
                  const Positioned(
                    top: 8,
                    left: 8,
                    child: DiscountBadge(text: 'NEW', type: BadgeType.isNew),
                  )
                else if (hasDiscount)
                  Positioned(
                    top: 8,
                    left: 8,
                    child:
                        DiscountBadge(text: discountText, type: BadgeType.sale),
                  ),

                // Floating Favorite Heart Icon
                Positioned(
                  bottom: -8,
                  right: 4,
                  child: Material(
                    elevation: 3,
                    shape: const CircleBorder(),
                    color: colorScheme.surface,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        AppHaptics.buttonPress();
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isFav
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 18,
                          color: isFav
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Rating Stars
            RatingBar(
              rating: product.rating,
              count: product.ratingCount,
            ),
            const SizedBox(height: 4),

            // Brand Sub-label
            AppText.caption(
              product.brand,
              isMuted: true,
              maxLines: 1,
            ),
            const SizedBox(height: 2),

            // Product Title
            AppText.body(
              product.title,
              fontWeight: FontWeight.bold,
              maxLines: 1,
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

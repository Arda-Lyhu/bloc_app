import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/product_detail/product_detail_bloc.dart';
import '../bloc/product_detail/product_detail_event.dart';
import '../bloc/product_detail/product_detail_state.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) =>
          sl<ProductDetailBloc>()..add(FetchProductDetailEvent(productId)),
      child: Scaffold(
        appBar: AppBar(
          title: const AppText.title('Product Details',
              fontWeight: FontWeight.bold),
          actions: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                AppHaptics.selection();
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const AppLoader(message: 'Loading product details...');
            } else if (state is ProductDetailError) {
              return AppError(
                message: state.message,
                onRetry: () => context
                    .read<ProductDetailBloc>()
                    .add(FetchProductDetailEvent(productId)),
              );
            } else if (state is ProductDetailLoaded) {
              final product = state.product;

              return ResponsiveContainer(
                maxWidth: 800,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image Gallery
                      SizedBox(
                        height: 320,
                        width: double.infinity,
                        child: PageView.builder(
                          itemCount: product.images.isNotEmpty
                              ? product.images.length
                              : 1,
                          itemBuilder: (context, index) {
                            final imageUrl = product.images.isNotEmpty
                                ? product.images[index]
                                : product.thumbnail;
                            return AppNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: AppText.overline(
                                    product.category.toUpperCase(),
                                    isPrimary: true,
                                  ),
                                  backgroundColor: colorScheme.primaryContainer
                                      .withValues(alpha: 0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: Colors.amber, size: 22),
                                    const SizedBox(width: 4),
                                    AppText.subtitle(
                                      '${product.rating}',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            AppText.h2(
                              product.title,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 8),
                            AppText.h1(
                              AppFormatters.currency(product.price),
                              isPrimary: true,
                              fontWeight: FontWeight.w900,
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 16),
                            const AppText.title(
                              'Description',
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 8),
                            AppText.body(
                              product.description,
                              isMuted: true,
                              fontSize: 15,
                            ),
                            const SizedBox(height: 36),
                            AppButton(
                              label: 'Add to Cart',
                              icon: const Icon(Icons.shopping_bag_outlined,
                                  size: 20),
                              onPressed: () {
                                AppAlerts.showSuccess(
                                  context,
                                  '${product.title} added to your bag!',
                                );
                              },
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

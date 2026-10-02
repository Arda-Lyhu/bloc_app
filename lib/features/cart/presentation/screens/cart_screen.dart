import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_name.dart';
import '../../../../core/core.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const AppText.h2('My Bag'),
        centerTitle: false,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.items;
          final totalAmount = state.totalAmount;
          final bloc = context.read<CartBloc>();

          if (cartItems.isEmpty) {
            return AppEmptyState(
              icon: Icons.shopping_bag_outlined,
              title: 'Your bag is empty',
              subtitle: 'Explore our popular items and add what you love!',
              actionLabel: 'Explore Products',
              onAction: () => context.goNamed(RouteName.home),
            );
          }

          return ResponsiveContainer(
            maxWidth: 800,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Container(
                        height: 124,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: colorScheme.outlineVariant
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(16),
                              ),
                              child: AppNetworkImage(
                                imageUrl: item.product.thumbnail,
                                width: 110,
                                height: 124,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: AppText.title(
                                            item.product.title,
                                            maxLines: 1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.close_rounded,
                                            size: 18,
                                            color: colorScheme.onSurfaceVariant
                                                .withValues(alpha: 0.6),
                                          ),
                                          onPressed: () async {
                                            final confirm =
                                                await AppDialogs.showConfirm(
                                              context: context,
                                              title: 'Remove item',
                                              message:
                                                  'Remove "${item.product.title}" from your bag?',
                                              confirmText: 'Remove',
                                              isDestructive: true,
                                              icon:
                                                  Icons.delete_outline_rounded,
                                            );
                                            if (confirm == true) {
                                              bloc.add(RemoveFromCartEvent(
                                                  item.product.id));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    AppText.caption(
                                      'Color: ${item.color}   Size: ${item.size}',
                                      isMuted: true,
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _buildCircleButton(
                                              context: context,
                                              icon: Icons.remove_rounded,
                                              onTap: () {
                                                AppHaptics.selection();
                                                bloc.add(DecrementQuantityEvent(
                                                    item.product.id));
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14),
                                              child: AppText.body(
                                                '${item.quantity}',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            _buildCircleButton(
                                              context: context,
                                              icon: Icons.add_rounded,
                                              onTap: () {
                                                AppHaptics.selection();
                                                bloc.add(IncrementQuantityEvent(
                                                    item.product.id));
                                              },
                                            ),
                                          ],
                                        ),
                                        AppText.title(
                                          AppFormatters.currency(
                                              item.totalPrice),
                                          fontWeight: FontWeight.bold,
                                          isPrimary: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                    border: Border(
                      top: BorderSide(
                        color:
                            colorScheme.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AppText.body('Total amount:', isMuted: true),
                          AppText.h2(
                            AppFormatters.currency(totalAmount),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'CHECK OUT',
                        icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                        onPressed: () {
                          context.pushNamed(RouteName.checkout);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircleButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            icon,
            size: 16,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

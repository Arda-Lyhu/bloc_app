import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_name.dart';
import '../../../../core/core.dart';
import '../../../products/presentation/widgets/product_item_card.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.h2('Favorites'),
        centerTitle: false,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return AppEmptyState(
              icon: Icons.favorite_border_rounded,
              title: 'No Favorites Yet',
              subtitle: 'Save items you love to view them anytime here!',
              actionLabel: 'Discover Products',
              onAction: () => context.goNamed(RouteName.home),
            );
          }

          return ResponsiveContainer(
            maxWidth: 1200,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.responsiveGridColumns,
                childAspectRatio: 0.58,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final product = state.favorites[index];
                return ProductItemCard(
                  product: product,
                  onTap: () {
                    context.pushNamed(
                      RouteName.productDetail,
                      pathParameters: {'id': product.id.toString()},
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

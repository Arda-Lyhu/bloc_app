import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/usecases/get_products.dart';
import '../bloc/products_cubit.dart';
import '../bloc/products_state.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getProductsUseCase = context.read<GetProducts>();

    return BlocProvider(
      create: (context) => ProductsCubit(getProducts: getProductsUseCase)..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover Products',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const AppLoader(message: 'Loading products with BLoC...');
            } else if (state is ProductsError) {
              return AppError(
                message: state.message,
                onRetry: () => context.read<ProductsCubit>().fetchProducts(),
              );
            } else if (state is ProductsLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products available.'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<ProductsCubit>().fetchProducts();
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        context.push('/product/${product.id}');
                      },
                    );
                  },
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

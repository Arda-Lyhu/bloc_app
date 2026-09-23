import 'package:app_scale/app/app_env.dart';
import 'package:app_scale/app/shell/main_shell.dart';
import 'package:app_scale/app/theme/app_theme.dart';
import 'package:app_scale/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:app_scale/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:app_scale/features/home/presentation/cubit/home_cubit.dart';
import 'package:app_scale/features/products/domain/entities/product.dart';
import 'package:app_scale/features/products/domain/repositories/product_repository.dart';
import 'package:app_scale/features/products/domain/usecases/get_product_detail.dart';
import 'package:app_scale/features/products/domain/usecases/get_products.dart';
import 'package:app_scale/features/products/domain/usecases/search_products.dart';
import 'package:app_scale/features/products/presentation/bloc/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    return [
      const Product(
        id: 1,
        title: 'Test Product',
        description: 'Test Description',
        category: 'electronics',
        brand: 'Dorothy Perkins',
        price: 99.99,
        discountPercentage: 20.0,
        oldPrice: 120.0,
        rating: 4.5,
        thumbnail: '',
        images: [],
      ),
    ];
  }

  @override
  Future<Product> getProductDetail(int id) async {
    return (await getProducts()).first;
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    return await getProducts();
  }
}

void main() {
  testWidgets('App renders smoke test with BLoC', (WidgetTester tester) async {
    AppEnv.init(environment: AppEnvironment.dev);

    final fakeRepo = FakeProductRepository();
    final getProducts = GetProducts(fakeRepo);
    final getProductDetail = GetProductDetail(fakeRepo);
    final searchProducts = SearchProducts(fakeRepo);

    final homeCubit = HomeCubit(getProducts: getProducts);
    final productsCubit = ProductsCubit(getProducts: getProducts);

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ProductRepository>.value(value: fakeRepo),
          RepositoryProvider<GetProducts>.value(value: getProducts),
          RepositoryProvider<GetProductDetail>.value(value: getProductDetail),
          RepositoryProvider<SearchProducts>.value(value: searchProducts),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductsCubit>.value(value: productsCubit..fetchProducts()),
            BlocProvider<HomeCubit>.value(value: homeCubit..fetchHomeFeed()),
            BlocProvider<CartCubit>(create: (context) => CartCubit()),
            BlocProvider<FavoritesCubit>(create: (context) => FavoritesCubit()),
          ],
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const MainShell(),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(MainShell), findsOneWidget);
    expect(find.text('Street clothes'), findsOneWidget);
    expect(find.text('Sale'), findsOneWidget);
  });
}

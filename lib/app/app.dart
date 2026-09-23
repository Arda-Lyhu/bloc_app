import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/cart/presentation/cubit/cart_cubit.dart';
import '../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/products/data/datasources/product_remote_data_source.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../features/products/domain/repositories/product_repository.dart';
import '../features/products/domain/usecases/get_product_detail.dart';
import '../features/products/domain/usecases/get_products.dart';
import '../features/products/domain/usecases/search_products.dart';
import '../features/products/presentation/bloc/products_cubit.dart';
import 'app_env.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEnv.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final remoteDataSource = ProductRemoteDataSourceImpl(dio: dio);
    final productRepository = ProductRepositoryImpl(remoteDataSource: remoteDataSource);
    final getProducts = GetProducts(productRepository);
    final getProductDetail = GetProductDetail(productRepository);
    final searchProducts = SearchProducts(productRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Dio>.value(value: dio),
        RepositoryProvider<ProductRepository>.value(value: productRepository),
        RepositoryProvider<GetProducts>.value(value: getProducts),
        RepositoryProvider<GetProductDetail>.value(value: getProductDetail),
        RepositoryProvider<SearchProducts>.value(value: searchProducts),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductsCubit>(
            create: (context) => ProductsCubit(getProducts: getProducts)..fetchProducts(),
          ),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(getProducts: getProducts)..fetchHomeFeed(),
          ),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(),
          ),
          BlocProvider<FavoritesCubit>(
            create: (context) => FavoritesCubit(),
          ),
        ],
        child: MaterialApp.router(
          title: 'E-Commerce BLoC App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}

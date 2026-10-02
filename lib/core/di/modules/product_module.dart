import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../../features/home/presentation/bloc/home_bloc.dart';
import '../../../features/products/data/datasources/product_remote_data_source.dart';
import '../../../features/products/data/repositories/product_repository_impl.dart';
import '../../../features/products/domain/repositories/product_repository.dart';
import '../../../features/products/domain/usecases/get_product_detail.dart';
import '../../../features/products/domain/usecases/get_products.dart';
import '../../../features/products/domain/usecases/search_products.dart';
import '../../../features/products/presentation/bloc/product/products_bloc.dart';
import '../../../features/products/presentation/bloc/product_detail/product_detail_bloc.dart';

/// Registers all product-feature dependencies.
void registerProductModule(GetIt sl) {
  // --- Data Sources ---
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // --- Use Cases ---
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetProductDetail(sl()));
  sl.registerLazySingleton(() => SearchProducts(sl()));

  // --- BLoCs (factory = new instance each time) ---
  sl.registerFactory(() => ProductsBloc(getProducts: sl()));
  sl.registerFactory(() => ProductDetailBloc(getProductDetail: sl()));
  sl.registerFactory(() => HomeBloc(getProducts: sl()));
}

import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductDetail(int id);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(ApiEndpoints.products);
    final List<dynamic> productsJson = response.data['products'];
    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<ProductModel> getProductDetail(int id) async {
    final response = await dio.get(ApiEndpoints.productDetail(id));
    return ProductModel.fromJson(response.data);
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await dio.get(
      ApiEndpoints.searchProducts,
      queryParameters: {'q': query},
    );
    final List<dynamic> productsJson = response.data['products'];
    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }
}

import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductDetail(int id);
  Future<List<ProductModel>> searchProducts(String query);
}

class ProductRemoteDataSourceImpl extends BaseRemoteDataSource
    implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({required Dio dio}) : super(ApiClient(dio));

  @override
  Future<List<ProductModel>> getProducts() async {
    return apiClient.get<List<ProductModel>>(
      path: ApiEndpoints.products,
      parser: (data) {
        final List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => ProductModel.fromJson(json)).toList();
      },
    );
  }

  @override
  Future<ProductModel> getProductDetail(int id) async {
    return apiClient.get<ProductModel>(
      path: ApiEndpoints.productDetail(id),
      parser: (data) => ProductModel.fromJson(data),
    );
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    return apiClient.get<List<ProductModel>>(
      path: ApiEndpoints.searchProducts,
      queryParameters: {'q': query},
      parser: (data) {
        final List<dynamic> productsJson = data['products'];
        return productsJson.map((json) => ProductModel.fromJson(json)).toList();
      },
    );
  }
}

import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductDetail(int id);
  Future<List<Product>> searchProducts(String query);
}

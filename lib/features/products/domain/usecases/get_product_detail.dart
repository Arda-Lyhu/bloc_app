import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetail {
  final ProductRepository repository;

  GetProductDetail(this.repository);

  Future<Product> call(int id) async {
    return await repository.getProductDetail(id);
  }
}

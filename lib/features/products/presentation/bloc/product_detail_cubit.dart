import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_product_detail.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductDetail getProductDetail;

  ProductDetailCubit({required this.getProductDetail})
      : super(ProductDetailInitial());

  Future<void> fetchProductDetail(int id) async {
    emit(ProductDetailLoading());
    try {
      final product = await getProductDetail(id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}

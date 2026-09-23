import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_product_detail.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetail getProductDetail;

  ProductDetailBloc({required this.getProductDetail})
      : super(ProductDetailInitial()) {
    on<FetchProductDetailEvent>(_onFetchProductDetail);
  }

  Future<void> _onFetchProductDetail(
    FetchProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    try {
      final product = await getProductDetail(event.id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}

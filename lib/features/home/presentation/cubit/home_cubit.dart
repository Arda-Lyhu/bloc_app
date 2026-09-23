import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/domain/usecases/get_products.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProducts getProducts;

  HomeCubit({required this.getProducts}) : super(HomeInitial());

  Future<void> fetchHomeFeed() async {
    emit(HomeLoading());
    try {
      final products = await getProducts();
      final saleItems = products.where((p) => p.discountPercentage > 0).toList();
      final newItems = products.where((p) => p.isNew).toList();
      emit(HomeLoaded(
        saleProducts: saleItems.isNotEmpty ? saleItems : products,
        newProducts: newItems.isNotEmpty ? newItems : products,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

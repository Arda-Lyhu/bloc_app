import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/domain/usecases/get_products.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProducts getProducts;

  HomeBloc({required this.getProducts}) : super(HomeInitial()) {
    on<FetchHomeFeedEvent>(_onFetchHomeFeed);
  }

  Future<void> _onFetchHomeFeed(
    FetchHomeFeedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await getProducts();
      final saleItems =
          products.where((p) => p.discountPercentage > 0).toList();
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

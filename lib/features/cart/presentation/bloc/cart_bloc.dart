import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item.dart';
import '../../../products/domain/entities/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(
          CartState(
            items: [
              CartItem(
                product: const Product(
                  id: 101,
                  title: 'Pullover',
                  description: 'Cotton pullover in black',
                  category: 'clothes',
                  brand: 'Mango',
                  price: 51.0,
                  rating: 4.8,
                  thumbnail:
                      'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&w=400&q=80',
                  images: [],
                ),
                quantity: 1,
                size: 'L',
                color: 'Black',
              ),
              CartItem(
                product: const Product(
                  id: 102,
                  title: 'T-Shirt',
                  description: 'White basic t-shirt',
                  category: 'clothes',
                  brand: 'LIndex',
                  price: 30.0,
                  rating: 4.5,
                  thumbnail:
                      'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=400&q=80',
                  images: [],
                ),
                quantity: 1,
                size: 'M',
                color: 'White',
              ),
            ],
          ),
        ) {
    on<AddToCartEvent>(_onAddToCart);
    on<IncrementQuantityEvent>(_onIncrementQuantity);
    on<DecrementQuantityEvent>(_onDecrementQuantity);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final index =
        state.items.indexWhere((item) => item.product.id == event.product.id);
    if (index >= 0) {
      final existing = state.items[index];
      final updatedList = List<CartItem>.from(state.items);
      updatedList[index] = existing.copyWith(quantity: existing.quantity + 1);
      emit(state.copyWith(items: updatedList));
    } else {
      emit(state.copyWith(
          items: [...state.items, CartItem(product: event.product)]));
    }
  }

  void _onIncrementQuantity(
      IncrementQuantityEvent event, Emitter<CartState> emit) {
    final updatedList = state.items.map((item) {
      if (item.product.id == event.productId) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedList));
  }

  void _onDecrementQuantity(
      DecrementQuantityEvent event, Emitter<CartState> emit) {
    final updatedList = state.items.map((item) {
      if (item.product.id == event.productId && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedList));
  }

  void _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) {
    final updatedList =
        state.items.where((item) => item.product.id != event.productId).toList();
    emit(state.copyWith(items: updatedList));
  }
}

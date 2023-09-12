import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/product.dart';

class CartProductNotifier extends StateNotifier<List<Cart>> {
  CartProductNotifier() : super([]);
  void addItemToCart(Cart newItem) {
    state = [...state, newItem];
  }

  void updateItemQuantity(int id) {
    print('UPDATE');
    var index = state.indexWhere((element) => element.id == id);
    state[index].quantity = state[index].quantity + 1;
    state = [...state];
  }

  void decreaseAndDeleteItemQuantity(int id) {
    print('DECREASE');
    var index = state.indexWhere((element) => element.id == id);
    state[index].quantity = state[index].quantity - 1;
    if (state[index].quantity <= 0) {
      print('DELETE');
      state.removeAt(index);
    }
    state = [...state];
  }

  void deleteItem(int id) {
    print('DELETE');
    var index = state.indexWhere((element) => element.id == id);
    state.removeAt(index);
    state = [...state];
  }

  void toggleCart(Product product) {
    final addCart = Cart(
        id: product.id,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price,
        quantity: 1);
    // final aa =    state.firstWhere((e) => e.id == product.id);
    state = [...state, addCart];
  }
}

final cartProvider =
    StateNotifierProvider<CartProductNotifier, List<Cart>>((ref) {
  return CartProductNotifier();
});

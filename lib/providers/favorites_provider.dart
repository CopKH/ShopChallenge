import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/models/product.dart';

class FavoriteProductNotifier extends StateNotifier<List<Product>> {
  FavoriteProductNotifier() : super([]);
  void toggleProductFavoriteStatus(Product product) {
    final productFavorite = state.contains(product);
    if (productFavorite) {
      print(productFavorite);
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }
}

final favoriteProductProvider =
    StateNotifierProvider<FavoriteProductNotifier, List<Product>>((ref) {
  return FavoriteProductNotifier();
});

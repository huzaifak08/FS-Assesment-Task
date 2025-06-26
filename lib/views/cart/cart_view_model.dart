import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/models/product.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(ProductModel product) {
    final existingCartItem = state.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product),
    );

    if (existingCartItem.quantity == 1) {
      state = [...state, CartItem(product: product)];
    } else {
      existingCartItem.quantity++;
      state = [...state];
    }
  }

  void updateQuantity(ProductModel product, int quantity) {
    if (quantity <= 0) return;

    final cartItem = state.firstWhere((item) => item.product.id == product.id);
    cartItem.quantity = quantity;
    state = [...state];
  }

  void removeFromCart(ProductModel product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void removeAllItemsFromCart() {
    state = [];
  }
}

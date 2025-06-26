import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/views/cart/cart_view_model.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cartHeader(context, cartItems),
              SizedBox(height: 20),
              Expanded(
                child: cartItems.isEmpty
                    ? _emptyCart()
                    : AnimatedList(
                        key: _listKey,
                        initialItemCount: cartItems.length,
                        itemBuilder: (context, index, animation) {
                          return _buildCartItem(
                            context,
                            cartItems[index],
                            animation,
                            index,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cartHeader(BuildContext context, List<CartItem> cartItems) {
    int totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
    int totalQuantity = cartItems.fold(0, (sum, item) => sum + item.quantity);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Cart Summary", style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        Text(
          "Total items: $totalQuantity",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 8),
        Text(
          "Total Price: \$$totalPrice",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    CartItem cartItem,
    Animation<double> animation,
    int index,
  ) {
    final product = cartItem.product;

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: Card(
          shadowColor: AppColors.whiteColor,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                // Product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "\$${product.price * cartItem.quantity}",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Quantity controls
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (cartItem.quantity > 1) {
                          ref
                              .read(cartProvider.notifier)
                              .updateQuantity(product, cartItem.quantity - 1);
                        }
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "${cartItem.quantity}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(cartProvider.notifier)
                            .updateQuantity(product, cartItem.quantity + 1);
                      },
                      icon: Icon(Icons.add_circle_outline, color: Colors.green),
                    ),
                  ],
                ),
                // Remove button
                IconButton(
                  onPressed: () {
                    final cart = ref.read(cartProvider);

                    final itemIndex = cart.indexOf(cartItem);

                    if (itemIndex != -1) {
                      _listKey.currentState!.removeItem(
                        itemIndex,
                        (context, animation) => _buildCartItem(
                          context,
                          cartItem,
                          animation,
                          itemIndex,
                        ),
                        duration: Duration(milliseconds: 300),
                      );

                      Future.delayed(Duration(milliseconds: 300), () {
                        ref.read(cartProvider.notifier).removeFromCart(product);
                      });
                    }
                  },
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            "Your cart is empty!",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

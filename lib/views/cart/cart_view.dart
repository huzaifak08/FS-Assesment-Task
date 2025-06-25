import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/models/product.dart';
import 'package:fs_task_assesment/providers/products_provider.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  // Add a GlobalKey for the AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: Colors.white,
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

  Widget _cartHeader(BuildContext context, List<ProductModel> cartItems) {
    int totalPrice = cartItems.fold(0, (sum, item) => sum + item.price);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cart Summary",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Total items: ${cartItems.length}",
          style: TextStyle(color: Colors.grey[600]),
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
    ProductModel product,
    Animation<double> animation,
    int index,
  ) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: Card(
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Remove button
                IconButton(
                  onPressed: () {
                    // Get the current cart
                    final cart = ref.read(cartProvider);

                    // Find the index of the product to remove
                    final itemIndex = cart.indexOf(product);

                    if (itemIndex != -1) {
                      // First remove the item with animation
                      _listKey.currentState!.removeItem(
                        itemIndex,
                        (context, animation) => _buildCartItem(
                          context,
                          product,
                          animation,
                          itemIndex,
                        ),
                        duration: Duration(milliseconds: 300),
                      );

                      // Then update the state after a small delay to let the animation complete
                      Future.delayed(Duration(milliseconds: 300), () {
                        ref.read(cartProvider.notifier).state = cart
                            .where((item) => item != product)
                            .toList();
                      });
                    }
                  },
                  icon: Icon(Icons.remove_circle_outline, color: Colors.red),
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

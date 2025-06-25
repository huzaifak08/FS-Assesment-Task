import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/components/image_display_widget.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/models/product.dart';
import 'package:fs_task_assesment/views/cart/cart_view_model.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel product;
  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartAnimController;

  @override
  void initState() {
    super.initState();
    _cartAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _cartAnimController.dispose();
    super.dispose();
  }

  // Add to cart method
  void _onAddToCart(ProductModel product, WidgetRef ref) {
    final cartItems = ref.read(cartProvider);
    final existingItem = cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product),
    );

    if (!cartItems.contains(existingItem)) {
      ref.read(cartProvider.notifier).addToCart(product);
      _cartAnimController.forward();
    } else {
      ref.read(cartProvider.notifier).removeFromCart(product);
      _cartAnimController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.55,
              child: Hero(
                tag: 'product-image-${product.id}',
                child: ImageDisplayWidget(
                  mediaId: product.id.toString(),
                  imageUrl: product.image,
                  imageFor: 'product',
                  showProgress: false,
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.48,
              minChildSize: 0.48,
              maxChildSize: 0.90,
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 16),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    controller: controller,
                    children: [
                      const SizedBox(height: 16),
                      Center(
                        child: Container(
                          width: 60,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "\$${(product.price * (1 - product.discount / 100)).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          if (product.discount > 0)
                            ScaleTransition(
                              scale: Tween<double>(begin: 0.8, end: 1.0)
                                  .animate(
                                    CurvedAnimation(
                                      parent: _cartAnimController,
                                      curve: Curves.elasticOut,
                                    ),
                                  ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "-${product.discount.toStringAsFixed(0)}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(width: 10),
                          if (product.discount > 0)
                            Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 16,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Consumer to listen to cart state
                      Consumer(
                        builder: (context, ref, child) {
                          final cartItems = ref.watch(cartProvider);
                          final isInCart = cartItems.any(
                            (cartItem) => cartItem.product.id == product.id,
                          );

                          return AnimatedBuilder(
                            animation: _cartAnimController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 1 + _cartAnimController.value * 0.05,
                                child: Opacity(
                                  opacity: 1 - _cartAnimController.value * 0.2,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isInCart
                                          ? Colors.green
                                          : AppColors.primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 32,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                    ),
                                    icon: Icon(
                                      isInCart
                                          ? Icons.check_circle
                                          : Icons.add_shopping_cart,
                                      size: 28,
                                      color: AppColors.whiteColor,
                                    ),
                                    label: Text(
                                      isInCart ? "Added" : "Add to Cart",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                    onPressed: () => _onAddToCart(product, ref),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 16,
              left: 16,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.8),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

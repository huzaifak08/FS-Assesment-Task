import 'package:flutter/material.dart';
import 'package:fs_task_assesment/components/image_display_widget.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/models/product.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel product;
  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartAnimController;
  bool _addedToCart = false;

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

  void _onAddToCart() {
    setState(() => _addedToCart = !_addedToCart);
    if (_addedToCart) {
      _cartAnimController.forward();
    } else {
      _cartAnimController.reverse();
    }
    // Trigger your actual add-to-cart logic here
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
            // Parallax background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.55,
              child: Hero(
                tag: 'product-image-${product.id}',
                // child: Image.network(product.image, fit: BoxFit.cover),
                child: ImageDisplayWidget(
                  mediaId: product.id.toString(),
                  imageUrl: product.image,
                  imageFor: 'product',
                  showProgress: false,
                ),
              ),
            ),
            // Content card
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
                      // Animated Add to Cart button
                      AnimatedBuilder(
                        animation: _cartAnimController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1 + _cartAnimController.value * 0.05,
                            child: Opacity(
                              opacity: 1 - _cartAnimController.value * 0.2,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _addedToCart
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
                                  _addedToCart
                                      ? Icons.check_circle
                                      : Icons.add_shopping_cart,
                                  size: 28,
                                  color: AppColors.whiteColor,
                                ),
                                label: Text(
                                  _addedToCart ? "Added" : "Add to Cart",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                onPressed: _onAddToCart,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
            // Back button
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

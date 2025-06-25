import 'package:flutter/material.dart';
import 'package:fs_task_assesment/components/image_display_widget.dart';
import 'package:fs_task_assesment/models/product.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  const ProductTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String displayTitle = product.title;
    List<String> titleWords = product.title.split(' ');

    // Check if title has more than 2 words
    if (titleWords.length > 2) {
      // Only take the first two words
      displayTitle = titleWords.sublist(0, 2).join(' ');
    }
    return InkWell(
      onTap: onTap,
      child: GridTile(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.08,
            vertical: MediaQuery.sizeOf(context).height * 0.015,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ImageDisplayWidget(
                      mediaId: product.id.toString(),
                      imageUrl: product.image,
                      imageFor: 'product',
                      showProgress: true,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  Text(
                    displayTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.heart_broken),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

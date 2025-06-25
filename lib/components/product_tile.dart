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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5), // Shadow for a nice floating effect
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              SizedBox(
                height:
                    MediaQuery.sizeOf(context).height *
                    0.2, // Set height for the image
                width: double.infinity,
                child: ImageDisplayWidget(
                  mediaId: product.id.toString(),
                  imageUrl: product.image,
                  imageFor: 'product',
                  showProgress: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * 0.01,
                  horizontal: MediaQuery.sizeOf(context).width * 0.02,
                ),
                child: Text(
                  displayTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Handle long titles
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.02,
                ),
                child: Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

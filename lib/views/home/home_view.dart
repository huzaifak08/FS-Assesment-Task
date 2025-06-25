import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/components/product_tile.dart';
import 'package:fs_task_assesment/providers/products_provider.dart';
import 'package:fs_task_assesment/views/product_detail/product_detail_view.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsProvider = ref.watch(productNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.02,
            horizontal: MediaQuery.sizeOf(context).height * 0.02,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "FS Programmers",
                    style: TextStyle(
                      fontSize: 24, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .black, // Set the color to black or any color you prefer
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              SearchBar(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                  Colors.grey.withOpacity(0.1),
                ),
                leading: const Icon(Icons.search),
                hintText: 'Search Product',
                onChanged: (value) {},
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

              productsProvider.when(
                data: (data) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.6, // Aspect ratio for tiles
                      ),
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailView(product: data[index]),
                              ),
                            );
                          },
                          product: data![index],
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text("Error Occurred")),
                loading: () => _buildShimmerLoading(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6, // Number of shimmer items
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shimmer effect for the product image
                  Flexible(
                    child: Container(
                      height:
                          MediaQuery.sizeOf(context).height *
                          0.2, // Fix the height to match ProductTile
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ), // Adjust spacing
                  // Shimmer effect for the product title
                  Flexible(
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ), // Adjust spacing
                  // Shimmer effect for the product price
                  Flexible(
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                      width: 100, // Adjust width for consistency
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/components/product_tile.dart';
import 'package:fs_task_assesment/providers/products_provider.dart';
import 'package:fs_task_assesment/views/product_detail/product_detail_view.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  String searchQuery = '';
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    _searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsyncValue = searchQuery.isEmpty
        ? ref.watch(productNotifierProvider)
        : ref.watch(searchProductsProvider(searchQuery));

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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              SearchBar(
                focusNode: _searchFocusNode,
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(
                  Colors.grey.withOpacity(0.1),
                ),
                leading: const Icon(Icons.search),
                hintText: 'Search Product',
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.trim();
                  });
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

              productsAsyncValue.when(
                data: (products) {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: products?.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          onTap: () {
                            if (_searchFocusNode.hasFocus) {
                              _searchFocusNode.unfocus();
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailView(product: products[index]),
                              ),
                            );
                          },
                          product: products![index],
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text("Error Occurred: $error")),
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
        itemCount: 6,
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
                  Flexible(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  Flexible(
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                  Flexible(
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                      width: 100,
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

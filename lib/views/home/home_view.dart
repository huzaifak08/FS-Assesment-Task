import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/components/product_tile.dart';
import 'package:fs_task_assesment/providers/products_provider.dart';
import 'package:fs_task_assesment/views/product_detail/product_detail_view.dart';

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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // CircleAvatar(
                  //   radius: MediaQuery.sizeOf(context).width * 0.07,
                  //   backgroundImage: const AssetImage("assets/profile.png"),
                  // ),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
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
                    Center(child: Text("Error Occoured")),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

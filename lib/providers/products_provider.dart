import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/models/product.dart';
import 'package:fs_task_assesment/services/products_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_provider.g.dart';

// final searchProvider = StateProvider<List<ProductModel>>((ref) => []);

@Riverpod(keepAlive: true)
class ProductNotifier extends _$ProductNotifier {
  @override
  Future<List<ProductModel>?> build() async {
    return await getAllProducts();
  }

  Future<List<ProductModel>?> getAllProducts() async {
    final productList = await ProductsService().getAllProductsData();

    if (productList != null) {
      return productList;
    }

    return null;
  }
}

@riverpod
Future<List<ProductModel>> searchProducts(Ref ref, String query) async {
  final allProducts = await ref.watch(productNotifierProvider.future);
  if (query.isNotEmpty) {
    if (allProducts != null) {
      List<ProductModel> searchProducts = allProducts
          .where(
            (element) =>
                element.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      return searchProducts;
    } else {
      return allProducts ?? [];
    }
  } else {
    return allProducts ?? [];
  }
}

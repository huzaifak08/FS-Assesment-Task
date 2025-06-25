import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fs_task_assesment/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> callFakeStoreAPI() async {
    try {
      final response = await http.get(
        Uri.parse("https://fakestoreapi.in/api/products"),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        List<dynamic> dynamicList = jsonResponse['products'];

        List<ProductModel> productsList = dynamicList
            .map((e) => ProductModel.fromMap(e))
            .toList();

        await saveAllProductsData(products: productsList);
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> saveAllProductsData({
    required List<ProductModel> products,
  }) async {
    try {
      for (int index = 0; index < products.length - 1; index++) {
        await _firestore
            .collection('products')
            .doc(products[index].id.toString())
            .set({
              "id": products[index].id,
              "title": products[index].title,
              "image": products[index].image,
              "price": products[index].price,
              "description": products[index].description,
              "brand": products[index].brand,
              "model": products[index].model,
              "color": products[index].color,
              "category": products[index].category,
              "discount": products[index].discount,
            })
            .then((value) {
              return true;
            })
            .onError((error, stackTrace) {
              return false;
            });
      }

      return false;
    } on FirebaseException catch (exception) {
      throw Exception(exception.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<List<ProductModel>?> getAllProductsData() async {
    try {
      final snapshot = await _firestore.collection('products').get();

      final products = snapshot.docs
          .map((e) => ProductModel.fromMap(e.data()))
          .toList();

      if (products.isNotEmpty) {
        return products;
      }

      return null;
    } on FirebaseException catch (exception) {
      throw Exception(exception.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}

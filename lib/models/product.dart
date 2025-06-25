import 'dart:convert';

class ProductModel {
  final int id;
  final String title;
  final String image;
  final int price;
  final String description;
  final String brand;
  final String model;
  final String color;
  final String category;
  final int discount;
  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.category,
    required this.discount,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? image,
    int? price,
    String? description,
    String? brand,
    String? model,
    String? color,
    String? category,
    int? discount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      category: category ?? this.category,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
      'brand': brand,
      'model': model,
      'color': color,
      'category': category,
      'discount': discount,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      price: map['price']?.toInt() ?? 0,
      description: map['description'] ?? '',
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      color: map['color'] ?? '',
      category: map['category'] ?? '',
      discount: map['discount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, image: $image, price: $price, description: $description, brand: $brand, model: $model, color: $color, category: $category, discount: $discount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.image == image &&
        other.price == price &&
        other.description == description &&
        other.brand == brand &&
        other.model == model &&
        other.color == color &&
        other.category == category &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        price.hashCode ^
        description.hashCode ^
        brand.hashCode ^
        model.hashCode ^
        color.hashCode ^
        category.hashCode ^
        discount.hashCode;
  }
}

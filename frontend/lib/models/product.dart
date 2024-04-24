import 'dart:convert';

import 'package:frontend/constants/size.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final double salePrice;
  final double salePercentage;
  final String detailDescription;
  final Size size;
  final double weight;
  final String color;
  final String material;
  final int stock;
  final int sold;
  final double ratingAvg;
  final int totalRating;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.salePercentage,
    required this.detailDescription,
    required this.size,
    required this.weight,
    required this.color,
    required this.material,
    required this.stock,
    required this.sold,
    required this.ratingAvg,
    required this.totalRating,
    required this.imageUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'sale_price': salePrice,
      'sale_percentage': salePercentage,
      'detail_description': detailDescription,
      'size': size.value,
      'weight': weight,
      'color': color,
      'material': material,
      'stock': stock,
      'sold': sold,
      'rating_avg': ratingAvg,
      'total_rating': totalRating,
      'image_urls': name,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      salePrice: map['sale_price'] ?? 0,
      salePercentage: map['sale_percentage'] ?? 0,
      detailDescription: map['detail_description'] ?? '',
      size: Size.values
              .where(
                (size) => size.value == map['size'],
              )
              .firstOrNull ??
          Size.standard,
      weight: map['weight'] ?? 0,
      color: map['color'] ?? '',
      material: map['material'] ?? '',
      stock: map['stock'] ?? 0,
      sold: map['sold'] ?? 0,
      ratingAvg: map['rating_avg'] ?? 0,
      totalRating: map['total_rating'] ?? 0,
      imageUrls: map['image_urls'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}

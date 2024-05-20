import 'dart:convert';

import 'package:frontend/models/product.dart';

class ProductListResponse {
  final int page;
  final List<Product> results;
  final int totalPages;
  final int totalResults;

  const ProductListResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'results': results.map((x) => x.toMap()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults
    };
  }

  factory ProductListResponse.fromMap(Map<String, dynamic> map) {
    return ProductListResponse(
      page: map['page'] ?? 0,
      results: List<Product>.from(
        map['results']?.map(
          (x) => Product.fromMap(x),
        ),
      ),
      totalPages: map['total_pages'] ?? 0,
      totalResults: map['total_results'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductListResponse.fromJson(String source) =>
      ProductListResponse.fromMap(json.decode(source));
}

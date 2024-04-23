import 'dart:convert';

import 'package:frontend/models/product.dart';

class ImportProductRecord {
  final int id;
  final Product product;
  final int quantity;
  final DateTime importDate;

  ImportProductRecord({
    required this.id,
    required this.product,
    required this.quantity,
    required this.importDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
      'export_date': importDate,
    };
  }

  factory ImportProductRecord.fromMap(Map<String, dynamic> map) {
    return ImportProductRecord(
      id: map['id'] ?? 0,
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] ?? 0,
      importDate: map['export_date'] ?? new DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImportProductRecord.fromJson(String source) =>
      ImportProductRecord.fromMap(json.decode(source));
}

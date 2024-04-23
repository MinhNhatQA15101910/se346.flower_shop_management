import 'dart:convert';

import 'package:frontend/models/product.dart';

class ExportProductRecord {
  final int id;
  final Product product;
  final int quantity;
  final DateTime exportDate;

  ExportProductRecord({
    required this.id,
    required this.product,
    required this.quantity,
    required this.exportDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
      'export_date': exportDate,
    };
  }

  factory ExportProductRecord.fromMap(Map<String, dynamic> map) {
    return ExportProductRecord(
      id: map['id'] ?? 0,
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] ?? 0,
      exportDate: map['export_date'] ?? new DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExportProductRecord.fromJson(String source) =>
      ExportProductRecord.fromMap(json.decode(source));
}

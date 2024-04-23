import 'dart:convert';

import 'package:frontend/constants/order_status.dart';
import 'package:frontend/models/product.dart';

class Order {
  final int id;
  final int userId;
  final double productPrice;
  final double shippingPrice;
  final OrderStatus status;
  final DateTime estimatedReceiveDate;
  final DateTime? orderDate;
  final DateTime? inDeliveryDate;
  final DateTime? receiveDate;
  final String province;
  final String district;
  final String ward;
  final String detailAddress;
  final String receiverName;
  final String receiverPhoneNumber;
  final List<Product> products;
  final List<int> quantities;

  const Order({
    required this.id,
    required this.userId,
    required this.productPrice,
    required this.shippingPrice,
    required this.status,
    required this.estimatedReceiveDate,
    this.orderDate,
    this.inDeliveryDate,
    this.receiveDate,
    required this.province,
    required this.district,
    required this.ward,
    required this.detailAddress,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.products,
    required this.quantities,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'product_price': productPrice,
      'shipping_price': shippingPrice,
      'status': status.value,
      'estimated_receive_date': estimatedReceiveDate,
      'order_date': orderDate,
      'in_delivery_date': inDeliveryDate,
      'receive_date': receiveDate,
      'province': province,
      'district': district,
      'ward': ward,
      'detail_address': detailAddress,
      'receiver_name': receiverName,
      'receiver_phone_number': receiverPhoneNumber,
      'products': products.map((p) => p.toMap()).toList(),
      'quantities': quantities,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? 0,
      productPrice: map['product_price'] ?? 0,
      shippingPrice: map['shipping_price'] ?? 0,
      status: OrderStatus.values
              .where((os) => os.value == map['status'])
              .firstOrNull ??
          OrderStatus.pending,
      estimatedReceiveDate: map['estimated_receive_date'] ?? 0,
      orderDate: map['order_date'] ?? new DateTime.now(),
      inDeliveryDate: map['in_delivery_date'] ?? new DateTime.now(),
      receiveDate: map['receive_date'] ?? new DateTime.now(),
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      ward: map['ward'] ?? '',
      detailAddress: map['detail_address'] ?? '',
      receiverName: map['receiver_name'] ?? '',
      receiverPhoneNumber: map['receiver_phone_number'] ?? '',
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(
            x['product'],
          ),
        ),
      ),
      quantities: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

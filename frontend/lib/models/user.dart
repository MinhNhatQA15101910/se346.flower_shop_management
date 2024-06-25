import 'dart:convert';

import 'package:frontend/models/product.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final String imageUrl;
  final String role;
  final String token;
  final List<Product> products;
  final List<int> quantities;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.imageUrl,
    required this.role,
    required this.token,
    required this.products,
    required this.quantities,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'image_url': imageUrl,
      'role': role,
      'token': token,
      'products': products.map((p) => p.toMap()).toList(),
      'quantities': quantities,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      imageUrl: map['image_url'] ?? '',
      role: map['role'] ?? '',
      token: map['token'] ?? '',
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(x),
        ),
      ),
      quantities: List<int>.from(
        map['quantities'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? imageUrl,
    String? role,
    String? token,
    List<Product>? products,
    List<int>? quantities,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
      token: token ?? this.token,
      products: products ?? this.products,
      quantities: quantities ?? this.quantities,
    );
  }
}

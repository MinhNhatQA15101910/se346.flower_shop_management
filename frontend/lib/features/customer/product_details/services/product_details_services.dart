import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/constants/size.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  Future<Product> fetchProductDetails(
    BuildContext context,
    int productId,
  ) async {
    // Create an instance of Product to store the fetched product details
    Product product = Product(
      id: 0,
      name: '',
      price: 0.0,
      salePrice: 0.0,
      salePercentage: 0.0,
      detailDescription: '',
      size: Size.small,
      weight: 0.0,
      color: '',
      material: '',
      stock: 0,
      sold: 0,
      ratingAvg: 0.0,
      totalRating: 0,
      imageUrls: [],
    );
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/customer/products/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(
            jsonEncode(jsonDecode(res.body)),
          );
        },
      );
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return product;
  }

  Future<List<Product>> fetchAllRecommendedProducts(
    BuildContext context,
    int page,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/customer/recommended-products?page=$page'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (var object in jsonDecode(res.body)['results']) {
            productList.add(
              Product.fromJson(
                jsonEncode(object),
              ),
            );
          }
        },
      );
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return productList;
  }
}

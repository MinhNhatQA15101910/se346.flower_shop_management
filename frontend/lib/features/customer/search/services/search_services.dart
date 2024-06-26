import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/constants/sort_options.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchService {
  Future<List<Product>> fetchResults(
    BuildContext context,
    String keyword,
    SortOption sortOption,
    String minPrice,
    String maxPrice,
    int page,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Product> productList = [];
    try {
      final url =
          '$uri/customer/products?keyword=${keyword}&sort=${sortOption.type}&order=${sortOption.order}&min_price=${minPrice}&max_price=${maxPrice}&page=${page}';
      print('url: $url');
      http.Response res = await http.get(
        Uri.parse(
            '$uri/customer/products?keyword=${keyword}&sort=${sortOption.type}&order=${sortOption.order}&min_price=${minPrice}&max_price=${maxPrice}&page=${page}'),
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

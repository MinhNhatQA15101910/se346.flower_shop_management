import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartService {
  Future<bool> addToCart(
    BuildContext context,
    int productId,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    bool isSuccess = false;

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/customer/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(<String, int>{
          'product_id': productId,
        }),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          isSuccess = true;
          User user = userProvider.user;
          userProvider.setUserFromModel(
            user.copyWith(
              products: List<Product>.from(
                jsonDecode(res.body)['products']?.map(
                  (x) => Product.fromMap(x),
                ),
              ),
              quantities: List<int>.from(
                jsonDecode(res.body)['quantities'],
              ),
            ),
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
    return isSuccess;
  }

  Future<bool> removeFromCart(
    BuildContext context,
    int productId,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool isSuccess = false;

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/customer/remove-from-cart/$productId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (res.statusCode == 200) {
        isSuccess = true;
        User user = userProvider.user;
        userProvider.setUserFromModel(
          user.copyWith(
            products: List<Product>.from(
              jsonDecode(res.body)['products']?.map(
                (x) => Product.fromMap(x),
              ),
            ),
            quantities: List<int>.from(
              jsonDecode(res.body)['quantities'],
            ),
          ),
        );
      } else {
        IconSnackBar.show(
          context,
          label: 'Failed to remove product from cart.',
          snackBarType: SnackBarType.fail,
        );
      }
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return isSuccess;
  }

  Future<bool> deleteFromCart(
    BuildContext context,
    int productId,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool isSuccess = false;

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/customer/delete-from-cart/$productId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (res.statusCode == 200) {
        isSuccess = true;
        User user = userProvider.user;
        userProvider.setUserFromModel(
          user.copyWith(
            products: List<Product>.from(
              jsonDecode(res.body)['products']?.map(
                (x) => Product.fromMap(x),
              ),
            ),
            quantities: List<int>.from(
              jsonDecode(res.body)['quantities'],
            ),
          ),
        );
      } else {
        IconSnackBar.show(
          context,
          label: 'Failed to remove product from cart.',
          snackBarType: SnackBarType.fail,
        );
      }
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return isSuccess;
  }
}

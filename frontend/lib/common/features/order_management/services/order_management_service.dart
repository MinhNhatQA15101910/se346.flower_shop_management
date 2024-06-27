import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OrderManagementService {
  Future<List<Order>> getAllOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    List<Order> orders = [];

    try {
      late http.Response response;
      if (userProvider.user.role == 'admin') {
        response = await http.get(
          Uri.parse('$uri/customer/orders'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
        );
      } else {
        response = await http.get(
          Uri.parse('$uri/customer/orders?user_id=${userProvider.user.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
        );
      }

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (var object in jsonDecode(response.body)) {
            orders.add(
              Order.fromJson(
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

    return orders;
  }
}

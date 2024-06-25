import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/statistic/models/chart_value.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StatisticService {
  Future<List<ChartValue>> fetchAllChartValues(
    BuildContext context,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<ChartValue> chartValueList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/product-analytics/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (var object in jsonDecode(res.body)) {
            chartValueList.add(
              ChartValue.fromJson(
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

    return chartValueList;
  }

  Future<List<ChartValue>> fetchAllChartValuesRevenue(
    BuildContext context,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<ChartValue> chartValueList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/revenue-analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (var object in jsonDecode(res.body)) {
            chartValueList.add(
              ChartValue.fromJson(
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

    return chartValueList;
  }

  Future<double> getTotalSales(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    double value = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/total-sales'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (response.statusCode == 200) {
        String cleanedString =
            response.body.replaceAll('"', ''); // Remove the quotes
        value = double.parse(cleanedString);
      } else {
        throw Exception('Failed to load total sales');
      }
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return value;
  }

  Future<double> getTotalProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    double value = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/total-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (response.statusCode == 200) {
        String cleanedString =
            response.body.replaceAll('"', ''); // Remove the quotes
        value = double.parse(cleanedString);
      } else {
        throw Exception('Failed to load total products');
      }
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return value;
  }

  Future<double> getTotalOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    double value = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/total-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (response.statusCode == 200) {
        String cleanedString =
            response.body.replaceAll('"', ''); // Remove the quotes
        value = double.parse(cleanedString);
      } else {
        throw Exception('Failed to load total orders');
      }
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return value;
  }

  Future<double> getTotalCustomers(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    double value = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/total-customers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (response.statusCode == 200) {
        String cleanedString =
            response.body.replaceAll('"', ''); // Remove the quotes
        value = double.parse(cleanedString);
      } else {
        throw Exception('Failed to load total customers');
      }
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return value;
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductManagementService {
  Future<List<String>> _fetchNames({
    required BuildContext context,
    required String endpoint,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    List<String> names = [];

    try {
      final response = await http.get(
        Uri.parse('$uri/customer/$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        names = jsonResponse.map((item) => item['name'].toString()).toList();
      } else {
        throw Exception('Failed to load $endpoint');
      }
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return names;
  }

  Future<List<String>> getCategoryNames({
    required BuildContext context,
  }) async {
    return await _fetchNames(context: context, endpoint: 'categories');
  }

  Future<List<String>> getOccasionNames({
    required BuildContext context,
  }) async {
    return await _fetchNames(context: context, endpoint: 'occasions');
  }

  Future<List<String>> getTypeNames({
    required BuildContext context,
  }) async {
    return await _fetchNames(context: context, endpoint: 'types');
  }
}

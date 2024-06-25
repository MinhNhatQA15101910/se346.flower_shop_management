import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:frontend/models/product.dart';

import 'package:frontend/constants/error_handling.dart';

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

  Future<void> addProduct({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      // final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

      // CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
      //   CloudinaryFile.fromFile(
      //     image.path,
      //     folder: name,
      //   ),
      // );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        body: jsonEncode(
          {
            "name": 0,
            "price": 0,
            "sale_percentage": 0,
            "detail_description": 0,
            "size": 0,
            "weight": 0,
            "color": 0,
            "material": 0,
            "stock": 0,
            "type_ids": [],
            "occasion_ids": [],
            "image_urls": []
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          IconSnackBar.show(
            context,
            label: 'Add product successfully',
            snackBarType: SnackBarType.success,
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
  }
}

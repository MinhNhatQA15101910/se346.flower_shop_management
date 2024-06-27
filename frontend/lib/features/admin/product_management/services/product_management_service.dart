import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/sort_options.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:frontend/models/product.dart';

import 'package:frontend/constants/error_handling.dart';

class ProductManagementService {
  Future<List<Product>> fetchAllProducts(
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
        Uri.parse('$uri/customer/products?page=$page'),
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

  Future<List<Type>> fetchAllTypes(
    BuildContext context,
    int categoryId,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Type> typeList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/customer/types?category_id=$categoryId'),
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
            typeList.add(
              Type.fromJson(
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

    return typeList;
  }

  Future<List<Occasion>> fetchAllOccasions(
    BuildContext context,
    int categoryId,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Occasion> occasionList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/customer/occasions?category_id=$categoryId'),
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
            occasionList.add(
              Occasion.fromJson(
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

    return occasionList;
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
    required String name,
    required String price,
    required String salePercentage,
    required String detailDescription,
    required String size,
    required String weight,
    required String color,
    required String material,
    required String stock,
    required String type_ids,
    required String occasion_ids,
    required List<File> imageUrls,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

      List<String> uploadedImageUrls = [];

      for (File imageUrl in imageUrls) {
        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            imageUrl.path,
            folder: 'products/$name',
          ),
        );
        uploadedImageUrls.add(cloudinaryResponse.secureUrl);
      }

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        body: jsonEncode(
          {
            "name": name,
            "price": price,
            "sale_percentage": salePercentage,
            "detail_description": detailDescription,
            "size": size.isNotEmpty ? size : 'Small',
            "weight": weight,
            "color": color,
            "material": material,
            "stock": stock,
            "image_urls": uploadedImageUrls,
            "type_ids": type_ids,
            "occasion_ids": occasion_ids,
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
            label: 'Product added successfully',
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

  Future<void> updateProduct({
    required BuildContext context,
    required String productId,
    String? name,
    String? price,
    String? salePercentage,
    String? detailDescription,
    String? size,
    String? weight,
    String? color,
    String? material,
    String? stock,
    List<File>? imageUrls,
    String? type_ids,
    String? occasion_ids,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

      List<String> uploadedImageUrls = [];

      if (imageUrls != null) {
        for (File imageUrl in imageUrls) {
          CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              imageUrl.path,
              folder: name ?? 'default_folder',
            ),
          );
          uploadedImageUrls.add(cloudinaryResponse.secureUrl);
        }
      }

      Map<String, dynamic> updateFields = {};

      if (name != null) updateFields['name'] = name;
      if (price != null) updateFields['price'] = price;
      if (salePercentage != null)
        updateFields['sale_percentage'] = salePercentage;
      if (detailDescription != null)
        updateFields['detail_description'] = detailDescription;
      if (size != null) updateFields['size'] = size;
      if (weight != null) updateFields['weight'] = weight;
      if (color != null) updateFields['color'] = color;
      if (material != null) updateFields['material'] = material;
      if (stock != null) updateFields['stock'] = stock;
      if (uploadedImageUrls.isNotEmpty)
        updateFields['image_urls'] = uploadedImageUrls;
      if (type_ids != null) updateFields['type_ids'] = type_ids;
      if (occasion_ids != null) updateFields['occasion_ids'] = occasion_ids;

      http.Response response = await http.put(
        Uri.parse('$uri/admin/update-product/$productId'),
        body: jsonEncode(updateFields),
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
            label: 'Product updated successfully',
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

  Future<void> deleteProduct({
    required BuildContext context,
    required int productId,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/delete-product/$productId'),
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
            label: 'Product deleted successfully',
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

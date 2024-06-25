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
    required String name,
    required double price,
    required double salePrice,
    required double salePercentage,
    required String detailDescription,
    required Size size,
    required double weight,
    required String color,
    required String material,
    required int stock,
    required int sold,
    required double ratingAvg,
    required int totalRating,
    required List<String> imageUrls,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

      List<String> uploadedImageUrls = [];

      for (String imageUrl in imageUrls) {
        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            imageUrl,
            folder: name,
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
            "sale_price": salePrice,
            "sale_percentage": salePercentage,
            "detail_description": detailDescription,
            "size": size,
            "weight": weight,
            "color": color,
            "material": material,
            "stock": stock,
            "sold": sold,
            "rating_avg": ratingAvg,
            "total_rating": totalRating,
            "image_urls": uploadedImageUrls,
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
    double? price,
    double? salePrice,
    double? salePercentage,
    String? detailDescription,
    Size? size,
    double? weight,
    String? color,
    String? material,
    int? stock,
    int? sold,
    double? ratingAvg,
    int? totalRating,
    List<String>? imageUrls,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

      List<String> uploadedImageUrls = [];

      if (imageUrls != null) {
        for (String imageUrl in imageUrls) {
          CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              imageUrl,
              folder: name ?? 'default_folder',
            ),
          );
          uploadedImageUrls.add(cloudinaryResponse.secureUrl);
        }
      }

      Map<String, dynamic> updateFields = {};

      if (name != null) updateFields['name'] = name;
      if (price != null) updateFields['price'] = price;
      if (salePrice != null) updateFields['sale_price'] = salePrice;
      if (salePercentage != null)
        updateFields['sale_percentage'] = salePercentage;
      if (detailDescription != null)
        updateFields['detail_description'] = detailDescription;
      if (size != null) updateFields['size'] = size;
      if (weight != null) updateFields['weight'] = weight;
      if (color != null) updateFields['color'] = color;
      if (material != null) updateFields['material'] = material;
      if (stock != null) updateFields['stock'] = stock;
      if (sold != null) updateFields['sold'] = sold;
      if (ratingAvg != null) updateFields['rating_avg'] = ratingAvg;
      if (totalRating != null) updateFields['total_rating'] = totalRating;
      if (uploadedImageUrls.isNotEmpty)
        updateFields['image_urls'] = uploadedImageUrls;

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
}

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryManagementService {
  Future<Type> getType({
    required int typeId,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    Type type = Type(
      id: 0,
      name: '',
      imageUrl: '',
    );

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/types/$typeId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      type = Type.fromJson(response.body);
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return type;
  }

  Future<void> addType({
    required int categoryId,
    required String name,
    required File image,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

      CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          folder: 'types/$name',
        ),
      );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-type'),
        body: jsonEncode(
          {
            'category_id': categoryId,
            'name': name,
            'image_url': cloudinaryResponse.secureUrl
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
            label: 'Add category successfully',
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

  Future<void> updateType({
    required int typeId,
    required String name,
    File? image,
    String? imageUrl,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      String finalImageUrl = imageUrl ?? '';

      if (image != null) {
        final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            folder: 'types/$name',
          ),
        );

        finalImageUrl = cloudinaryResponse.secureUrl;
      }

      http.Response response = await http.patch(
        Uri.parse('$uri/admin/update-type/$typeId'),
        body: jsonEncode(
          {'name': name, 'image_url': finalImageUrl},
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
            label: 'Update type successfully',
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

  Future<void> deleteType({
    required int typeId,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/delete-type/$typeId'),
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
            label: 'Update type successfully',
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

  Future<Occasion?> getOccasion({
    required int occasionId,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    Occasion? occasion = null;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/occasions/$occasionId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      occasion = Occasion.fromJson(response.body);
    } catch (error) {
      IconSnackBar.show(
        context,
        label: error.toString(),
        snackBarType: SnackBarType.fail,
      );
    }

    return occasion;
  }

  Future<void> addOccasion({
    required int categoryId,
    required String name,
    required File image,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

      CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          folder: 'types/$name',
        ),
      );

      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-occasion'),
        body: jsonEncode(
          {
            'category_id': categoryId,
            'name': name,
            'image_url': cloudinaryResponse.secureUrl
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
            label: 'Add category successfully',
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

  Future<void> updateOccasion({
    required int occasionId,
    required String name,
    File? image,
    String? imageUrl,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      String finalImageUrl = imageUrl ?? '';

      if (image != null) {
        final cloudinary = CloudinaryPublic('dauyd6npv', 'nkklif97');

        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            folder: 'types/$name',
          ),
        );

        finalImageUrl = cloudinaryResponse.secureUrl;
      }

      http.Response response = await http.patch(
        Uri.parse('$uri/admin/update-occasion/$occasionId'),
        body: jsonEncode(
          {'name': name, 'image_url': finalImageUrl},
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
            label: 'Update type successfully',
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

  Future<void> deleteOccasion({
    required int occasionId,
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/delete-occasion/$occasionId'),
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
            label: 'Update type successfully',
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

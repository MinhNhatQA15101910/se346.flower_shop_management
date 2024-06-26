import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/checkout/models/district.dart';
import 'package:frontend/features/customer/checkout/models/province.dart';
import 'package:frontend/features/customer/checkout/models/ward.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CheckoutService {
  static const String apiUrl = 'https://vapi.vnappmob.com';

  Future<List<Province>> fetchProvinces() async {
    final response = await http.get(Uri.parse('$apiUrl/api/province'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> results = jsonResponse['results'];
      return results.map((data) => Province.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load provinces');
    }
  }

  Future<List<District>> fetchDistricts(String provinceId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/api/province/district/$provinceId'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> results = jsonResponse['results'];
      return results.map((data) => District.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load districts');
    }
  }

  Future<List<Ward>> fetchWards(String districtId) async {
    final response =
        await http.get(Uri.parse('$apiUrl/api/province/ward/$districtId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> results = jsonResponse['results'];
      return results.map((data) => Ward.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load wards');
    }
  }

  Future<bool> createOrderFromCart(
    BuildContext context,
    DateTime estimated_receive_date,
    String province,
    String district,
    String ward,
    String detail_address,
    String receiver_name,
    String receiver_phone_number,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    bool isSuccess = false;

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/customer/create-order-from-cart'),
        body: jsonEncode(
          {
            //'estimated_receive_date': estimated_receive_date,
            'province': province,
            'district': district,
            'ward': ward,
            'detail_address': detail_address,
            'receiver_name': receiver_name,
            'receiver_phone_number': receiver_phone_number,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          isSuccess = true;
          User user = userProvider.user;
          userProvider.setUserFromModel(
            user.copyWith(
              products: [],
              quantities: [],
            ),
          );
          IconSnackBar.show(
            context,
            label: 'Ceate order successfully!',
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
    return isSuccess;
  }

  Future<bool> createOrderFromProduct(
    BuildContext context,
    int product_id,
    DateTime estimated_receive_date,
    String province,
    String district,
    String ward,
    String detail_address,
    String receiver_name,
    String receiver_phone_number,
  ) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    bool isSuccess = false;

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/customer/create-order-from-product'),
        body: jsonEncode(
          {
            'product_id': product_id,
            //'estimated_receive_date': estimated_receive_date,
            'province': province,
            'district': district,
            'ward': ward,
            'detail_address': detail_address,
            'receiver_name': receiver_name,
            'receiver_phone_number': receiver_phone_number,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          isSuccess = true;
          User user = userProvider.user;
          userProvider.setUserFromModel(
            user.copyWith(
              products: [],
              quantities: [],
            ),
          );
          IconSnackBar.show(
            context,
            label: 'Ceate order successfully!',
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
    return isSuccess;
  }
}

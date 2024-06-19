import 'dart:convert';
import 'package:frontend/models/district.dart';
import 'package:frontend/models/province.dart';
import 'package:frontend/models/ward.dart';
import 'package:http/http.dart' as http;

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
}

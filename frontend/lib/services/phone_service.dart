import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/phone_number.dart';

class PhoneService {
  final String _baseUrl = 'http://localhost:3000/api/phone-info';
  final String _token = dotenv.env['API_TOKEN'] ?? '';

  Future<List<PhoneNumber>> fetchPhoneNumbers() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((e) => PhoneNumber.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load phone numbers');
    }
  }
}

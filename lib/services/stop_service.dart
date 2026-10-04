import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/stop.dart';

class StopService {
  
  static const String baseUrl = 'https://brts-backend-fnq5.onrender.com';
  static Future<List<Stop>> getStops() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/stops'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((json) => Stop.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load BRTS stops');
    }
  }
}
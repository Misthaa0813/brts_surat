import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/route.dart';

class RouteService {
  static const String baseUrl = 'https://brts-backend-fnq5.onrender.com';
  static Future<List<BusRoute>> findRoutes(
    int fromStopId,
    int toStopId,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/find-route?from=$fromStopId&to=$toStopId',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<dynamic> routes = data['routes'];

      return routes
          .map((json) => BusRoute.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to find route');
    }
  }
}
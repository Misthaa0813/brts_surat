import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/bus.dart';
import '../models/bus_details.dart';

class BusService {
  static const String baseUrl =
      'https://brts-backend-fnq5.onrender.com';

  // Get all bus numbers
  static Future<List<Bus>> getBuses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/buses'),
    );

    print('BUSES STATUS: ${response.statusCode}');
    print('BUSES RESPONSE: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((json) => Bus.fromJson(json))
          .toList();
    } else {
      throw Exception(
        'Failed to load bus numbers',
      );
    }
  }

  // Get complete route details for a selected bus
  static Future<List<BusRouteDetails>> getBusDetails(
    String busNo,
  ) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/bus-details?bus_no=${Uri.encodeComponent(busNo)}',
      ),
    );

    // Debug information
    print('-----------------------------------');
    print('BUS DETAILS REQUEST');
    print('Bus Number: $busNo');
    print('BUS DETAILS STATUS: ${response.statusCode}');
    print('BUS DETAILS RESPONSE: ${response.body}');
    print('-----------------------------------');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body);

      final List<dynamic> routes =
          data['routes'] ?? [];

      print('TOTAL ROUTES RECEIVED: ${routes.length}');

      return routes
          .map(
            (json) => BusRouteDetails.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    }

    if (response.statusCode == 404) {
      throw Exception(
        'Bus $busNo was not found.',
      );
    }

    throw Exception(
      'Failed to load bus details. '
      'Status code: ${response.statusCode}',
    );
  }
}
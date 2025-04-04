import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/eventmodel.dart';
// import the file where you defined Event, Events, etc.

class ApiService {
  static const String baseUrl = 'https://hackfest-backend-xrix.onrender.com/api';

  Future<Events> fetchEvents() async {
    print("started fetching");
    final url = Uri.parse('$baseUrl/events');
    final response = await http.get(url);
    print("nooo");
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');
    if (response.statusCode == 201) {
      final decoded = jsonDecode(response.body);
      return Events.fromJson(decoded);
    } else {
      throw Exception('Failed to load events');
    }
  }
}

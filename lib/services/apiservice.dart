import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sentinova/helper/demo_values.dart';
import 'package:sentinova/models/post_model.dart';
import '../helper/data.dart';
import '../models/event_model.dart';

class ApiService {
  static const String baseUrl = 'https://hackfest-backend-xrix.onrender.com/api';

  static Future<Events> fetchEvents() async {
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

  static Future<List<PostModel>> fetchPosts() async {
    return DemoValues.posts;

    Events events = await fetchEvents();
    for (Event event in events.events) {
      if (event.id == eventID) {
        return event.communityPosts;
      }
    }
    return []; // return empty list if eventID doesn't match any event
  }
}

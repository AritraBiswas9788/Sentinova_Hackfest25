import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sentinova/helper/demo_values.dart';
import 'package:sentinova/models/comment_model.dart';
import 'package:sentinova/models/post_model.dart';
import 'package:sentinova/models/user_model.dart';
import '../helper/data.dart';
import '../models/event_model.dart';

class ApiService {
  static const String baseUrl = 'https://hackfest-backend-xrix.onrender.com/api';

  static Future<List<UserModel>> fetchUsers() async {
    // print("started fetching");
    final url = Uri.parse('$baseUrl/users');
    final response = await http.get(url);
    // print("nooo");
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return UserList.fromJson(decoded).users;
    } else {
      throw Exception('Failed to load events');
    }
  }

  static Future<Events> fetchEvents() async {
    print("started fetching");
    final url = Uri.parse('$baseUrl/events');
    final response = await http.get(url);
    // print("nooo");
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');
    if (response.statusCode == 200) {
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

  static Future<void> addPost(PostModel post) async {
    final url = Uri.parse('$baseUrl/events/addPost');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'info': post.toJson().toString(),
        'eventId': eventID,
      }),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print(decoded);
    } else {
      throw Exception('Failed to add post');
    }
  }

  static Future<void> addComment(PostModel post, String comment) async {
    final url = Uri.parse('$baseUrl/events/updatePost');

    final commentModel = CommentModel(user: currUser!, comment: comment, time: DateTime.now());
    post.comments.add(commentModel);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'info': post.toJson(),
        'eventId': eventID,
        'postId' : post.id,
      }),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print(decoded);
    } else {
      throw Exception('Failed to add comment');
    }
  }

  static Future<void> addUser(UserModel user) async {
    final url = Uri.parse('$baseUrl/users');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: user.toJson(),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      print(decoded);
    } else {
      throw Exception('Failed to add user');
    }
  }


}

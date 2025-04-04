import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:sentinova/helper/constant.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class MongoService {
  static late Db db;
  static late DbCollection eventsCollection;

  /// Connect to MongoDB Atlas
  static Future<void> connect() async {
    // db = await Db.create(MONGO_URL);
    // await db.open();
    // inspect(db);
    // eventsCollection = db.collection(COLLECTION_NAME);
    // print('Connected to MongoDB');
  }

  /// Close the connection
  static Future<void> close() async {
    await db.close();
  }

  /// Upload a post to a specific event's community list
  static Future<bool> uploadPostToEvent(String eventId, PostModel post) async {
    final postDoc = {
      "id": post.id,
      "title": post.title,
      "summary": post.summary,
      "body": post.body,
      "imageURL": post.imageURL,
      "postTime": post.postTime.toIso8601String(),
      "reacts": post.reacts,
      "views": post.views,
      "author": {
        "id": post.author.id,
        "name": post.author.name,
        "email": post.author.email,
        "image": post.author.image,
        "followers": post.author.followers,
        "joined": post.author.joined.toIso8601String(),
        "posts": post.author.posts,
      },
      "comments": [],
    };

    try {
      await eventsCollection.updateOne(
        where.eq('_id', ObjectId.parse(eventId)),
        modify.push('community', postDoc),
      );
      return true;
    } catch (e) {
      print('Error adding post to event: $e');
      return false;
    }
  }

  /// Fetch all posts from a specific event's community
  static Future<List<PostModel>> fetchCommunityPosts(String eventId) async {
    try {
      final event = await eventsCollection.findOne(where.eq('_id', ObjectId.parse(eventId)));

      if (event == null || event['community'] == null) return [];

      final List<dynamic> communityPosts = event['community'];

      return communityPosts.map<PostModel>((p) {
        final author = p['author'];
        return PostModel(
          id: p['id'],
          title: p['title'],
          summary: p['summary'],
          body: p['body'],
          imageURL: p['imageURL'],
          postTime: DateTime.parse(p['postTime']),
          reacts: p['reacts'] ?? 0,
          views: p['views'] ?? 0,
          author: UserModel(
            id: author['id'],
            name: author['name'],
            email: author['email'],
            image: author['image'],
            followers: author['followers'],
            joined: DateTime.parse(author['joined']),
            posts: author['posts'],
          ),
          comments: [], // Add comment parsing later if needed
        );
      }).toList();
    } catch (e) {
      print("Error fetching community posts: $e");
      return [];
    }
  }
}

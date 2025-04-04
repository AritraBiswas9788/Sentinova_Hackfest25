import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sentinova/helper/demo_values.dart';
import 'package:sentinova/models/post_model.dart';
import 'package:sentinova/screens/sign_in.dart';
import 'package:sentinova/services/apiservice.dart';
import 'package:sentinova/models/user_model.dart';

import '../services/apiservice.dart';
import '../widgets/post_card.dart';
import 'create_post_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  late Future<List<PostModel>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Community Posts")),
      body: FutureBuilder<List<PostModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No posts available."));
          }

          final posts = snapshot.data!;
          // final posts = DemoValues.posts;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostCard(postData: DemoValues.posts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(FirebaseAuth.instance.currentUser == null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignIn()),
            );
          }
          else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreatePostScreen()),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Create Post"),
      ),
    );
  }
}

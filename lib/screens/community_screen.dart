import 'package:flutter/material.dart';
import 'package:sentinova/screens/create_post_screen.dart';
import '../helper/demo_values.dart';
import '../widgets/post_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
      ),
      body: ListView.builder(
        itemCount: DemoValues.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return PostCard(postData: DemoValues.posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        icon: Icon(Icons.add),
        label: Text("Create Post"),
      ),
    );
  }
}

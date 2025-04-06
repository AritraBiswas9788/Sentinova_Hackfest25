import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sentinova/helper/demo_values.dart';
import 'package:sentinova/models/post_model.dart';
import 'package:sentinova/screens/chatbot.dart';
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
  late ScrollController _scrollController;
  bool isFabExtended = true;

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService.fetchPosts();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (isFabExtended) setState(() => isFabExtended = false);
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (!isFabExtended) setState(() => isFabExtended = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.2, -0.5),
            radius: 1.5,
            colors: [
              Color(0xFF1A1447), // dark indigo
              Color(0xFF000000), // black
            ],
            stops: [0.3, 1.0],
          ),
        ),
        child: FutureBuilder<List<PostModel>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No posts available.",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            final posts = snapshot.data!;

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF3F3D9B),
                        Color(0xFF121212),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Theme(
                    data: ThemeData.dark().copyWith(
                      textTheme: Theme.of(context).textTheme.apply(
                        bodyColor: Colors.white,
                        displayColor: Colors.white,
                      ),
                    ),
                    child: PostCard(postData: post),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: "chatbot",
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () {
                Get.to(()=>GeminiChatPage());
              },
              //backgroundColor: Colors.tealAccent[700],
              child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white,),
            ),
            const SizedBox(width: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isFabExtended
                  ? FloatingActionButton.extended(
                key: const ValueKey('extended'),
                onPressed: _onFabPressed,
                icon: const Icon(Icons.add),
                label: const Text("Create Post"),
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                heroTag: "createPost",
              )
                  : FloatingActionButton(
                key: const ValueKey('collapsed'),
                onPressed: _onFabPressed,
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
                heroTag: "createPost",
              ),
            ),
          ],
        ),
      ),

    );
  }

  void _onFabPressed() {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const SignIn()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePostScreen()));
    }
  }
}

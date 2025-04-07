import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sentinova/helper/data.dart';
import 'package:sentinova/services/apiservice.dart';
import '../models/comment_model.dart';
import '../screens/sign_in.dart';
import '../widgets/inherited_post_model.dart';
import '../widgets/user_details_with_follow.dart';


class CommentsList extends StatefulWidget {
  const CommentsList({Key? key}) : super(key: key);

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<CommentModel> _comments;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _comments = List.from(InheritedPostModel.of(context).postData.comments);
  }

  void _handleSendComment() {
    if(FirebaseAuth.instance.currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignIn()),
      );
      return;
    }

    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      final post = InheritedPostModel.of(context).postData;

      setState(() {
        // ApiService.addComment(post, text);
        post.comments.add(CommentModel(user: currUser!, comment: text, time: DateTime.now()));
      });

      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Add a Comment", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "Write a comment...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
                onPressed: _handleSendComment,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            leading: Icon(Icons.comment),
            trailing: Text(_comments.length.toString()),
            title: Text("Comments"),
            children: [
              AnimatedList(
                key: _listKey,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                initialItemCount: _comments.length,
                itemBuilder: (context, index, animation) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _comments[index].user.name.toString(), // assuming user has name field
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _comments[index].comment,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class CommentsListKeyPrefix {
  static const String singleComment = "Comment";
  static const String commentUser = "Comment User";
  static const String commentText = "Comment Text";
  static const String commentDivider = "Comment Divider";
}

class _SingleComment extends StatelessWidget {
  final int index;

  const _SingleComment({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentData = InheritedPostModel.of(context).postData.comments[index];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserDetailsWithFollow(
              key: ValueKey("${CommentsListKeyPrefix.commentUser} $index"),
              userData: commentData.user,
            ),
            const SizedBox(height: 6),
            Text(
              commentData.comment,
              key: ValueKey("${CommentsListKeyPrefix.commentText} $index"),
            ),
          ],
        ),
      ),
    );

  }
}

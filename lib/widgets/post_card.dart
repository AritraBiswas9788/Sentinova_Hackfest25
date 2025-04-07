import 'package:flutter/material.dart';
import 'package:sentinova/helper/data.dart';
import '../helper/common.dart';
import '../models/post_model.dart';
import '../screens/post_page.dart';
import '../widgets/inherited_post_model.dart';
import '../widgets/post_stats.dart';
import '../widgets/post_time_stamp.dart';
import '../widgets/user_details.dart';

class PostCard extends StatelessWidget {
  final PostModel postData;
  String? currentUserId = currUser?.id;

  PostCard({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = isLandscape(context) ? 6 / 2 : (postData.isPoll ? 3.5 / 5 : 4 / 3);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
          return PostPage(postData: postData);
        }));
      },
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3A2D89), Color(0xFF0B0B0B), Color(0xFF000000)], // Purple to Black
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              //stops: [0.05, 1.0],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: InheritedPostModel(
            postData: postData,
            child: postData.isPoll
                ? PollPostWidget(post: postData)
                : const Column(
              children: <Widget>[
                _Post(),
                Divider(color: Colors.white24),
                _PostDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(children: <Widget>[_PostImage(), _PostTitleSummaryAndTime()]),
    );
  }
}

class _PostTitleSummaryAndTime extends StatelessWidget {
  const _PostTitleSummaryAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    final String title = postData.title;
    final String summary = postData.summary;
    final int flex = isLandscape(context) ? 5 : 3;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(summary,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
            const PostTimeStamp(alignment: Alignment.centerRight),
          ],
        ),
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    return Expanded(
      flex: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(postData.imageURL, fit: BoxFit.cover),
      ),
    );
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    return Container(
      alignment: Alignment.center,
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(flex: 3, child: UserDetails(userData: postData.author)),
          const Expanded(flex: 1, child: PostStats()),
        ],
      ),
    );
  }
}

class PollPostWidget extends StatefulWidget {
  final PostModel post;
  String? currentUserId = currUser?.id;

  PollPostWidget({super.key, required this.post});

  @override
  State<PollPostWidget> createState() => _PollPostWidgetState();
}

class _PollPostWidgetState extends State<PollPostWidget> {
  int? selectedOptionIndex;

  void submitVote() {
    if (selectedOptionIndex != null) {
      setState(() {
        widget.post.options[selectedOptionIndex!].votes++;
        String? uid = widget.currentUserId;
        if (uid != null) widget.post.votedUids.add(uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasVoted = widget.post.votedUids.contains(widget.currentUserId);
    final totalVotes =
    widget.post.options.fold<int>(0, (sum, option) => sum + option.votes);

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(widget.post.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              subtitle: Text(widget.post.summary,
                  style: const TextStyle(color: Colors.white70)),
            ),
            ...widget.post.options.asMap().entries.map((entry) {
              int index = entry.key;
              PollOption option = entry.value;
          
              if (hasVoted) {
                double percentage = totalVotes == 0 ? 0 : (option.votes / totalVotes);
                return ListTile(
                  title: Text(option.text,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: LinearProgressIndicator(
                    value: percentage,
                    color: Colors.white,
                    backgroundColor: Colors.white24,
                  ),
                  trailing: Text('${option.votes} votes',
                      style: const TextStyle(color: Colors.white70)),
                );
              } else {
                return RadioListTile<int>(
                  title: Text(option.text,
                      style: const TextStyle(color: Colors.white)),
                  activeColor: Colors.deepPurpleAccent,
                  value: index,
                  groupValue: selectedOptionIndex,
                  onChanged: (int? value) {
                    setState(() {
                      selectedOptionIndex = value;
                    });
                  },
                );
              }
            }),
            if (!hasVoted)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: submitVote,
                  child: const Text("Submit Vote"),
                ),
              ),
            const Divider(color: Colors.white24),
            const _PostDetails(),
          ],
        ),
      );
    }
  }

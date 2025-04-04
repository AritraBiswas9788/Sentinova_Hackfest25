
import 'package:flutter/material.dart';
import '../helper/common.dart';
import '../models/post_model.dart';
import '../screens/post_page.dart';
import '../widgets/inherited_post_model.dart';
import '../widgets/post_stats.dart';
import '../widgets/post_time_stamp.dart';
import '../widgets/user_details.dart';

class PostCard extends StatelessWidget {
  final PostModel postData;

  const PostCard({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = isLandscape(context) ? 6 / 2 : 6 / 3;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return PostPage(postData: postData);
            }));
      },
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Card(
          elevation: 2,
          child: Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(4.0),
            child: InheritedPostModel(
              postData: postData,
              child: const Column(
                children: <Widget>[
                  _Post(),
                  Divider(color: Colors.grey),
                  _PostDetails(),
                ],
              ),
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
    return const Expanded(
      flex: 3,
      child: Row(children: <Widget>[_PostImage(), _PostTitleSummaryAndTime()]),
    );
  }
}

class _PostTitleSummaryAndTime extends StatelessWidget {
  const _PostTitleSummaryAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    final TextStyle? titleTheme = Theme.of(context).textTheme.titleLarge;
    final TextStyle? summaryTheme = Theme.of(context).textTheme.bodyLarge;
    final String title = postData.title;
    final String summary = postData.summary;
    final int flex = isLandscape(context) ? 5 : 3;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(title, style: titleTheme),
                const SizedBox(height: 2.0),
                Text(summary, style: summaryTheme),
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
    return Expanded(flex: 2, child: Image.asset(postData.imageURL));
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    return Row(
      children: <Widget>[
        Expanded(flex: 3, child: UserDetails(userData: postData.author)),
        const Expanded(flex: 1, child: PostStats()),
      ],
    );
  }
}
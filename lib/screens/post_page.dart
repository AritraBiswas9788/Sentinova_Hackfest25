import 'package:flutter/material.dart';
import 'package:sentinova/widgets/user_details.dart';
import '../models/post_model.dart';
import '../themes.dart';
import '../widgets/comment_list.dart';
import '../widgets/inherited_post_model.dart';
import '../widgets/post_stats.dart';
import '../widgets/post_time_stamp.dart';
import '../widgets/user_details_with_follow.dart';

class PostPageKeys {
  static const ValueKey wholePage = ValueKey("wholePage");
  static const ValueKey bannerImage = ValueKey("bannerImage");
  static const ValueKey summary = ValueKey("summary");
  static const ValueKey mainBody = ValueKey("mainBody");
}

class PostPage extends StatelessWidget {
  final PostModel postData;

  const PostPage({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(postData.title),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: InheritedPostModel(
        postData: postData,
        child: ListView(
          key: PostPageKeys.wholePage,
          children: const <Widget>[
            _BannerImage(key: PostPageKeys.bannerImage),
            _NonImageContents(),
          ],
        ),
      ),
    );
  }
}

class _NonImageContents extends StatelessWidget {
  const _NonImageContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _Summary(key: PostPageKeys.summary),
          const PostTimeStamp(),
          const _MainBody(key: PostPageKeys.mainBody),
          UserDetails(userData: postData.author),
          const SizedBox(height: 8.0),
          const PostStats(),
          const SizedBox(height: 16),
          const CommentsList(),
        ],
      ),
    );
  }
}

class _BannerImage extends StatelessWidget {
  const _BannerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      InheritedPostModel.of(context).postData.imageURL,
      fit: BoxFit.fitWidth,
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.titleLarge?.color;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        InheritedPostModel.of(context).postData.summary,
        style: TextThemes.title.copyWith(color: color),
      ),
    );
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.bodyMedium?.color;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        InheritedPostModel.of(context).postData.body,
        style: TextThemes.body1.copyWith(color: color),
      ),
    );
  }
}

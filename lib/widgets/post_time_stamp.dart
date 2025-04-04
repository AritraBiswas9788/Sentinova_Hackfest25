import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../themes.dart';
import '../widgets/inherited_post_model.dart';

class PostTimeStamp extends StatelessWidget {
  final Alignment alignment;

  const PostTimeStamp({
    super.key,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;
    final TextStyle timeTheme = TextThemes.dateStyle;

    return Container(
      width: double.infinity,
      alignment: alignment,
      child: Text(postData.postTimeFormatted, style: timeTheme),
    );
  }
}
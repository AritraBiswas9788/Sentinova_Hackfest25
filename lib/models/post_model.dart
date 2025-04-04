import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';

class PostModel {
  final String id, title, summary, body, imageURL;
  final bool isPoll;
  final DateTime postTime;
  final int reacts, views;
  final UserModel author;
  final List<CommentModel> comments;
  final List<PollOption> options;
  List<String> votedUids;

  PostModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.body,
    required this.imageURL,
    required this.author,
    required this.postTime,
    required this.reacts,
    required this.views,
    required this.comments,
    this.isPoll = false,
    this.options = const [],
    this.votedUids = const [],
  });

  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(postTime);
}


class PollOption {
  final String text;
  int votes;

  PollOption({
    required this.text,
    this.votes = 0,
  });
}

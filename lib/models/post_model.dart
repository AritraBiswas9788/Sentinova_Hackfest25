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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      body: json['body'] ?? '',
      imageURL: json['imageURL'] ?? '',
      author: UserModel.fromJson(json['author'] ?? {}),
      postTime: DateTime.tryParse(json['postTime'] ?? '') ?? DateTime.now(),
      reacts: json['reacts'] ?? 0,
      views: json['views'] ?? 0,
      comments: (json['comments'] as List<dynamic>? ?? [])
          .map((e) => CommentModel.fromJson(e))
          .toList(),
      isPoll: json['isPoll'] ?? false,
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => PollOption.fromJson(e))
          .toList(),
      votedUids: List<String>.from(json['votedUids'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'summary': summary,
    'body': body,
    'imageURL': imageURL,
    'author': author.toJson(),
    'postTime': postTime.toIso8601String(),
    'reacts': reacts,
    'views': views,
    'comments': comments.map((e) => e.toJson()).toList(),
    'isPoll': isPoll,
    'options': options.map((e) => e.toJson()).toList(),
    'votedUids': votedUids,
  };
}

class PollOption {
  final String text;
  int votes;

  PollOption({
    required this.text,
    this.votes = 0,
  });

  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      text: json['text'] ?? '',
      votes: json['votes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'votes': votes,
  };
}

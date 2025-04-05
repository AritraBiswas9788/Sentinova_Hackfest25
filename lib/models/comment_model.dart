import 'package:flutter/material.dart';
import '../models/user_model.dart';

class CommentModel {
  final UserModel user;
  final String comment;
  final DateTime time;

  const CommentModel({
    required this.user,
    required this.comment,
    required this.time,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      user: UserModel.fromJson(json['user']),
      comment: json['comment'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'comment': comment,
      'time': time.toIso8601String(),
    };
  }
}

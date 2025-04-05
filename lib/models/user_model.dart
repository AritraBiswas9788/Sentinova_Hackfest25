import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String image;
  final DateTime joined;
  final int posts;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password = "",
    required this.image,
    required this.joined,
    required this.posts,
  });

  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(joined);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      image: json['image'] ?? '',
      joined: DateTime.tryParse(json['joined'] ?? '') ?? DateTime.now(),
      posts: json['posts'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'image': image,
    'joined': joined.toIso8601String(),
    'posts': posts,
  };
}

import 'package:flutter/material.dart';
import '../models/post_model.dart';

class InheritedPostModel extends InheritedWidget {
  final PostModel postData;
  final Widget child;

  const InheritedPostModel({
    super.key,
    required this.postData,
    required this.child,
  }) : super(child: child);

  static InheritedPostModel of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedPostModel>()
    as InheritedPostModel);
  }

  @override
  bool updateShouldNotify(InheritedPostModel oldWidget) {
    return true;
  }
}
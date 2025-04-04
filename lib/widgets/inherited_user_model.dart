import 'package:flutter/material.dart';
import '../models/user_model.dart';

class InheritedUserModel extends InheritedWidget {
  final UserModel userData;
  final Widget child;

  const InheritedUserModel({super.key, required this.userData, required this.child})
      : super(child: child);

  static InheritedUserModel of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedUserModel>()
    as InheritedUserModel);
  }

  @override
  bool updateShouldNotify(InheritedUserModel oldWidget) {
    return true;
  }
}
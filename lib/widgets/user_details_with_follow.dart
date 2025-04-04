import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/user_details.dart';

class UserDetailsWithFollowKeys {
  static const ValueKey userDetails = ValueKey("UserDetails");
  static const ValueKey follow = ValueKey("follow");
}

class UserDetailsWithFollow extends StatelessWidget {
  final UserModel userData;

  const UserDetailsWithFollow({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: UserDetails(
            key: UserDetailsWithFollowKeys.userDetails,
            userData: userData,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            key: UserDetailsWithFollowKeys.follow,
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.group_add),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
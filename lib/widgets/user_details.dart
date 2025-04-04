import 'package:flutter/material.dart';
import '../helper/common.dart';
import '../models/user_model.dart';
import '../widgets/inherited_user_model.dart';

class UserDetails extends StatelessWidget {
  final UserModel userData;

  const UserDetails({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return InheritedUserModel(
      userData: userData,
      child: Container(
        child: Row(children: <Widget>[_UserImage(), _UserNameAndEmail()]),
      ),
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  const _UserNameAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userData = InheritedUserModel.of(context).userData;
    final TextStyle? nameTheme = Theme.of(context).textTheme.titleMedium;
    final TextStyle? emailTheme = Theme.of(context).textTheme.bodyLarge;
    final int flex = isLandscape(context) ? 10 : 5;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(userData.name, style: nameTheme),
            SizedBox(height: 2.0),
            Text(userData.email, style: emailTheme),
          ],
        ),
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  const _UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userData = InheritedUserModel.of(context).userData;
    return Expanded(
      flex: 1,
      child: CircleAvatar(backgroundImage: AssetImage(userData.image)),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentinova/helper/data.dart';
import 'package:sentinova/services/apiservice.dart';

class InitUser{
  static initialize() async {
    if(FirebaseAuth.instance.currentUser == null) return;
    final email = FirebaseAuth.instance.currentUser?.email;
    final userList = await ApiService.fetchUsers();
    for(final user in userList) {
      if(user.email == email) {
        currUser = user;
        break;
      }
    }
  }
}
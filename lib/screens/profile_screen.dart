import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sentinova/screens/sign_in.dart';

import '../helper/constant.dart';
import '../helper/data.dart';
import '../helper/init_user.dart';
import '../widgets/loading_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (FirebaseAuth.instance.currentUser == null) {
      // delay to ensure navigation doesn't throw context errors
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignIn()),
        );
      });
    } else {
      getData();
    }
  }

  Future<void> getData() async {
    await InitUser.initialize();
    if (mounted) {
      setState(() => isFetched = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'N/A';

    return !isFetched
        ? const LoadingWidget()
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.grey.shade700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.5, 0.9],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white70,
                  minRadius: 60.0,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(currUser?.image ?? DEFAULT_IMG),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  currUser?.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                // const Text(
                //   'Ondc Merchant',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              _buildInfoTile("Email ID", currUser?.email ?? "Not available"),
              _buildInfoTile("Posts", (currUser?.posts ?? 0).toString()),
              _buildInfoTile("Reward points", calculatePoints(currUser?.posts ?? 0)),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  child: TextButton.icon(
                    onPressed: _showLogoutSheet,
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String subtitle) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.deepOrange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 18)),
        ),
        const Divider(indent: 15, endIndent: 15),
      ],
    );
  }

  void _showLogoutSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Are you sure you want to Logout?',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: logout,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('LOGOUT'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    displaySnackBar('Logged out!');
    Navigator.popUntil(context, ModalRoute.withName('/'));
    Navigator.pushReplacementNamed(context, '/sign_in');
  }

  void displaySnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  String calculatePoints(int posts) => '${posts * 100}';
}

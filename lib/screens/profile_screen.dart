import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
    final posts = 17;
    final points =  1100;
    final goal = 2000;
    final remaining = goal - points;
    final percent = (points / goal).clamp(0.0, 1.0);

    return !isFetched
        ? const LoadingWidget()
        : Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.2, -0.5), // Adjust for an offset effect
            radius: 1.5, // Adjust the spread
            colors: [
              Color(0xFF190B34), // Purple
              Color(0xFF0A0A0E), // Dark Purple / Black
            ],
            stops: [0.3, 1.0], // Control how colors blend
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.grey[700],
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(currUser?.image ?? DEFAULT_IMG),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  currUser?.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            CircularPercentIndicator(
              radius: 70,
              lineWidth: 8,
              percent: percent,
              center: Text(
                "$points pts",
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              backgroundColor: Colors.grey.shade800,
              progressColor: Colors.deepOrangeAccent,
              animation: true,
              animationDuration: 800,
            ),

            const SizedBox(height: 16),
            Center(
              child: Text(
                "$remaining points to next level",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                "🎉 Reward: 20% OFF Coupon",
                style: TextStyle(
                  color: Colors.greenAccent.shade200,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 30),

            _buildInfoTile("Email ID", userEmail ?? "Not available"),
            _buildInfoTile("Posts", posts.toString()),
            _buildInfoTile("Reward Points", "$points"),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: _showLogoutSheet,
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  void _showLogoutSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Are you sure you want to Logout?',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: logout,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('LOGOUT'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
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
}

import 'package:flutter/material.dart';

class RedditCard extends StatelessWidget {
  final String count;

  const RedditCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(69, 10, 10, 0.9), // red-950/90
            Color.fromRGBO(0, 0, 0, 0.9), // red-black gradient
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(255, 45, 0, 0.8), // reddit orange glow
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageIcon(
            AssetImage("assets/reddit.png"),
            color: Colors.white,
            size: 50,
          ),
          const SizedBox(height: 6),
          const Text(
            'Reddit',
            style: TextStyle(
              color: Color.fromRGBO(248, 113, 113, 1),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FacebookCard extends StatelessWidget {
  final String count;

  const FacebookCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(30, 58, 138, 1), // bg-[#0B1736]/90
            Color.fromRGBO(30, 58, 138, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(66, 103, 178, 0.75), // glow
            blurRadius: 18,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageIcon(
            AssetImage("assets/facebook.png"),
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 8),
          const Text(
            'Facebook',
            style: TextStyle(
              color: Color(0xFF60A5FA), // text-blue-400
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

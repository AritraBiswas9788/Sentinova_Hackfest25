import 'package:flutter/material.dart';

class InstagramCard extends StatelessWidget {
  final String count;

  const InstagramCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xE6400080), // purple-900/90
            Color(0xE6BE185D), // pink-700/90
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(193, 53, 132, 0.7), // Instagram glow
            blurRadius: 15,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageIcon(
            AssetImage("assets/instagram.png"),
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 8),
          const Text(
            'Instagram',
            style: TextStyle(
              color: Color.fromRGBO(244, 114, 182, 1),
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

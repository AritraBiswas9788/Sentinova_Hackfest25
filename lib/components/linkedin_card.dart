import 'package:flutter/material.dart';

class LinkedinCard extends StatelessWidget {
  final String count;

  const LinkedinCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(23, 37, 84, 1),
            Color.fromRGBO(23, 37, 84, 1), // bg-blue-950
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 119, 181, 0.7), // glow
            blurRadius: 15,
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
            AssetImage("assets/linkedin.png"),
            color: Colors.white,
            size: 42,
          ),
          const SizedBox(height: 8),
          const Text(
            'LinkedIn',
            style: TextStyle(
              color: Color.fromRGBO(96, 165, 250, 1), // text-gray-300
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

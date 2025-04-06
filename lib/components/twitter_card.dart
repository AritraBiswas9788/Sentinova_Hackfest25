import 'package:flutter/material.dart';

class TwitterCard extends StatelessWidget {
  final String count;

  const TwitterCard({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF18181B), // bg-zinc-900
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(255, 255, 255, 0.5), // glow
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
            AssetImage("assets/twitter.png"), // You can replace this with a custom X logo
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 8),
          const Text(
            'Twitter (X)',
            style: TextStyle(
              color: Color(0xFFD1D5DB), // text-gray-300
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

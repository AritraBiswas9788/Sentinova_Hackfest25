import 'package:flutter/material.dart';

import '../models/social_media_post.dart';

class TwitterPost extends StatelessWidget {
  final SocialMediaPost post;

  const TwitterPost({
    super.key,
    required this.post,
  });

  Color _getSentimentColor(String? sentiment) {
    switch (sentiment?.toLowerCase()) {
      case 'positive':
        return Colors.greenAccent.shade400;
      case 'negative':
        return Colors.redAccent.shade200;
      case 'neutral':
        return Colors.amberAccent.shade200;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF18181B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(255, 255, 255, 0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Icon + Platform
          Row(
            children: [
              const ImageIcon(
                AssetImage("assets/twitter.png"),
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 6),
              const Text(
                'Twitter (X)',
                style: TextStyle(
                  color: Color(0xFFD1D5DB),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (post.sentiment != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getSentimentColor(post.sentiment),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    post.sentiment!.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          // Username
          Text(
            post.username,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          // Truncated Post Content
          Text(
            post.text.length > 40 ? '${post.text.substring(0, 37)}...' : post.text,
            style: const TextStyle(
              color: Color(0xFFE5E7EB),
              fontSize: 12,
              height: 1.4,

            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

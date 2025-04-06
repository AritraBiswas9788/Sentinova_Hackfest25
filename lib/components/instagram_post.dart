import 'package:flutter/material.dart';

import '../models/social_media_post.dart';

class InstagramPost extends StatelessWidget {
  final SocialMediaPost post;

  const InstagramPost({super.key, required this.post});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: icon + label + sentiment
          Row(
            children: [
              const ImageIcon(
                AssetImage("assets/instagram.png"),
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 6),
              const Text(
                'Instagram',
                style: TextStyle(
                  color: Color.fromRGBO(244, 114, 182, 1),
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
          // Post content (truncated)
          Text(
            post.text.length > 40 ? '${post.text.substring(0, 37)}...' : post.text,
            style: const TextStyle(
              color: Color(0xFFFDF2F8), // Soft pink-ish white
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

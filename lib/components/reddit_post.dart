import 'package:flutter/material.dart';


import '../models/social_media_post.dart';

class RedditPost extends StatelessWidget {
  final SocialMediaPost post;

  const RedditPost({
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
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(69, 10, 10, 0.9), // red-950/90
            Color.fromRGBO(0, 0, 0, 0.9), // red-black gradient
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), // Slightly darker for Reddit tone
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(255, 69, 0, 0.3), // Reddit orange glow
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Reddit icon + label + sentiment
          Row(
            children: [
              const ImageIcon(
                AssetImage("assets/reddit.png"), // Ensure you have a reddit icon
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 6),
              const Text(
                'Reddit',
                style: TextStyle(
                  color: Color(0xFFF9FAFB),
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

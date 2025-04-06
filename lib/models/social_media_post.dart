class SocialMediaPost {
  final String platform;     // Platform name (Instagram, LinkedIn, etc.)
  final String postId;       // Unique post ID
  final String username;     // Author's username
  final String text;         // Post content
  final DateTime timestamp;  // Creation date/time
  final int? likes;          // Like count (nullable)
  final int? comments;       // Comment count (nullable)
  final int? shares;         // Reshare/Retweet count (nullable)
  final String? url;         // Post URL (nullable)
  String? sentiment;         // Sentiment analysis result (nullable, can be updated later)

  SocialMediaPost({
    required this.platform,
    required this.postId,
    required this.username,
    required this.text,
    required this.timestamp,
    this.likes,
    this.comments,
    this.shares,
    this.url,
    this.sentiment,
  });

  @override
  String toString() {
    final textPreview = text.length > 30 ? '${text.substring(0, 30)}...' : text;
    return 'SocialMediaPost(platform: $platform, user: $username, text: $textPreview, likes: $likes, shares: $shares, comments: $comments, timestamp: $timestamp, sentiment: $sentiment)';
  }
}

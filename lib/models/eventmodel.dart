class Events {
  Events({
    required this.events,
  });

  final List<Event> events;

  factory Events.fromJson(Map<String, dynamic> json){
    return Events(
      events: json["events"] == null ? [] : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
    );
  }

}

class Event {
  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.location,
    required this.mapUrl,
    required this.blocks,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.analysis,
    required this.posts,
  });

  final String? id;
  final String? name;
  final DateTime? date;
  final String? description;
  final String? location;
  final String? mapUrl;
  final List<Block> blocks;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final Analysis? analysis;
  final List<Post> posts;

  factory Event.fromJson(Map<String, dynamic> json){
    return Event(
      id: json["_id"],
      name: json["name"],
      date: DateTime.tryParse(json["date"] ?? ""),
      description: json["description"],
      location: json["location"],
      mapUrl: json["map_url"],
      blocks: json["blocks"] == null ? [] : List<Block>.from(json["blocks"]!.map((x) => Block.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      analysis: json["analysis"] == null ? null : Analysis.fromJson(json["analysis"]),
      posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    );
  }

}

class Analysis {
  Analysis({
    required this.keywordSentiment,
    required this.overallSentiment,
    required this.issuesAndPositives,
  });

  final KeywordSentiment? keywordSentiment;
  final OverallSentiment? overallSentiment;
  final IssuesAndPositives? issuesAndPositives;

  factory Analysis.fromJson(Map<String, dynamic> json){
    return Analysis(
      keywordSentiment: json["keyword_sentiment"] == null ? null : KeywordSentiment.fromJson(json["keyword_sentiment"]),
      overallSentiment: json["overall_sentiment"] == null ? null : OverallSentiment.fromJson(json["overall_sentiment"]),
      issuesAndPositives: json["issues_and_positives"] == null ? null : IssuesAndPositives.fromJson(json["issues_and_positives"]),
    );
  }

}

class IssuesAndPositives {
  IssuesAndPositives({
    required this.positive,
    required this.negative,
  });

  final List<String> positive;
  final List<String> negative;

  factory IssuesAndPositives.fromJson(Map<String, dynamic> json){
    return IssuesAndPositives(
      positive: json["positive"] == null ? [] : List<String>.from(json["positive"]!.map((x) => x)),
      negative: json["negative"] == null ? [] : List<String>.from(json["negative"]!.map((x) => x)),
    );
  }

}

class KeywordSentiment {
  KeywordSentiment({
    required this.keywords,
    required this.distribution,
  });

  final List<String> keywords;
  final KeywordSentimentDistribution? distribution;

  factory KeywordSentiment.fromJson(Map<String, dynamic> json){
    return KeywordSentiment(
      keywords: json["keywords"] == null ? [] : List<String>.from(json["keywords"]!.map((x) => x)),
      distribution: json["distribution"] == null ? null : KeywordSentimentDistribution.fromJson(json["distribution"]),
    );
  }

}

class KeywordSentimentDistribution {
  KeywordSentimentDistribution({
    required this.gSoC,
    required this.proposal,
    required this.deadline,
    required this.mentors,
    required this.beginner,
    required this.coding,
    required this.openSource,
  });

  final Beginner? gSoC;
  final Beginner? proposal;
  final Beginner? deadline;
  final Beginner? mentors;
  final Beginner? beginner;
  final Beginner? coding;
  final Beginner? openSource;

  factory KeywordSentimentDistribution.fromJson(Map<String, dynamic> json){
    return KeywordSentimentDistribution(
      gSoC: json["GSoC"] == null ? null : Beginner.fromJson(json["GSoC"]),
      proposal: json["Proposal"] == null ? null : Beginner.fromJson(json["Proposal"]),
      deadline: json["Deadline"] == null ? null : Beginner.fromJson(json["Deadline"]),
      mentors: json["Mentors"] == null ? null : Beginner.fromJson(json["Mentors"]),
      beginner: json["Beginner"] == null ? null : Beginner.fromJson(json["Beginner"]),
      coding: json["Coding"] == null ? null : Beginner.fromJson(json["Coding"]),
      openSource: json["Open Source"] == null ? null : Beginner.fromJson(json["Open Source"]),
    );
  }

}

class Beginner {
  Beginner({
    required this.veryPositive,
    required this.positive,
    required this.neutral,
    required this.negative,
    required this.veryNegative,
  });

  final int? veryPositive;
  final int? positive;
  final int? neutral;
  final int? negative;
  final int? veryNegative;

  factory Beginner.fromJson(Map<String, dynamic> json){
    return Beginner(
      veryPositive: json["very positive"],
      positive: json["positive"],
      neutral: json["neutral"],
      negative: json["negative"],
      veryNegative: json["very negative"],
    );
  }

}

class OverallSentiment {
  OverallSentiment({
    required this.overallLabel,
    required this.distribution,
  });

  final String? overallLabel;
  final ConfidenceClass? distribution;

  factory OverallSentiment.fromJson(Map<String, dynamic> json){
    return OverallSentiment(
      overallLabel: json["overall_label"],
      distribution: json["distribution"] == null ? null : ConfidenceClass.fromJson(json["distribution"]),
    );
  }

}

class ConfidenceClass {
  ConfidenceClass({
    required this.positive,
    required this.neutral,
    required this.negative,
  });

  final double? positive;
  final double? neutral;
  final double? negative;

  factory ConfidenceClass.fromJson(Map<String, dynamic> json){
    return ConfidenceClass(
      positive: json["positive"],
      neutral: json["neutral"],
      negative: json["negative"],
    );
  }

}

class Block {
  Block({
    required this.topLeft,
    required this.bottomRight,
    required this.id,
  });

  final BottomRight? topLeft;
  final BottomRight? bottomRight;
  final String? id;

  factory Block.fromJson(Map<String, dynamic> json){
    return Block(
      topLeft: json["topLeft"] == null ? null : BottomRight.fromJson(json["topLeft"]),
      bottomRight: json["bottomRight"] == null ? null : BottomRight.fromJson(json["bottomRight"]),
      id: json["_id"],
    );
  }

}

class BottomRight {
  BottomRight({
    required this.x,
    required this.y,
  });

  final double? x;
  final double? y;

  factory BottomRight.fromJson(Map<String, dynamic> json){
    return BottomRight(
      x: json["x"],
      y: json["y"],
    );
  }

}

class Post {
  Post({
    required this.platform,
    required this.postId,
    required this.username,
    required this.text,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.url,
    required this.sentiment,
  });

  final String? platform;
  final String? postId;
  final String? username;
  final String? text;
  final dynamic? timestamp;
  final double? likes;
  final int? comments;
  final int? shares;
  final dynamic url;
  final Sentiment? sentiment;

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      platform: json["platform"],
      postId: json["post_id"],
      username: json["username"],
      text: json["text"],
      timestamp: json["timestamp"],
      likes: json["likes"],
      comments: json["comments"],
      shares: json["shares"],
      url: json["url"],
      sentiment: json["sentiment"] == null ? null : Sentiment.fromJson(json["sentiment"]),
    );
  }

}

class Sentiment {
  Sentiment({
    required this.label,
    required this.confidence,
  });

  final String? label;
  final ConfidenceClass? confidence;

  factory Sentiment.fromJson(Map<String, dynamic> json){
    return Sentiment(
      label: json["label"],
      confidence: json["confidence"] == null ? null : ConfidenceClass.fromJson(json["confidence"]),
    );
  }

}

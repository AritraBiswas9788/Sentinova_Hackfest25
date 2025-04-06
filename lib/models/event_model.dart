import 'package:sentinova/models/post_model.dart';
import 'package:sentinova/models/user_model.dart';

class Events {
  Events({
    required this.events,
  });

  final List<Event> events;

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      events: json["events"] == null
          ? []
          : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "events": events.map((e) => e.toJson()).toList(),
    };
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
    required this.communityPosts,
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
  final List<PostModel> communityPosts;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json["_id"],
      name: json["name"],
      date: DateTime.tryParse(json["date"] ?? ""),
      description: json["description"],
      location: json["location"],
      mapUrl: json["map_url"],
      blocks: json["blocks"] == null
          ? []
          : List<Block>.from(json["blocks"].map((x) => Block.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      analysis:
      json["analysis"] == null ? null : Analysis.fromJson(json["analysis"]),
      posts: json["posts"] == null
          ? []
          : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),

      communityPosts: json["communityPosts"] == null
          ? []
          : List<PostModel>.from(json["communityPosts"]
          .where((x) => x["author"] != null)
          .map((x) => PostModel(
        id: x["id"],
        title: x["title"],
        summary: x["summary"],
        body: x["body"],
        imageURL: x["imageURL"],
        author: UserModel.fromJson(x["author"]),
        postTime: DateTime.tryParse(x["postTime"]) ?? DateTime.now(),
        reacts: x["reacts"],
        views: x["views"],
        comments: [], // Populate if comment data exists
        isPoll: x["isPoll"] ?? false,
        options: x["options"] == null
            ? []
            : List<PollOption>.from(x["options"].map((o) => PollOption(
          text: o["text"],
          votes: o["votes"],
        ))),
        votedUids: x["votedUids"] == null
            ? []
            : List<String>.from(x["votedUids"]),
      ))),


      // communityPosts: json["communityPosts"] == null
      //     ? []
      //     : List<PostModel>.from(json["communityPosts"].map((x) => PostModel(
      //   id: x["id"],
      //   title: x["title"],
      //   summary: x["summary"],
      //   body: x["body"],
      //   imageURL: x["imageURL"],
      //   author: UserModel.fromJson(x["author"]),
      //   postTime: DateTime.tryParse(x["postTime"]) ?? DateTime.now(),
      //   reacts: x["reacts"],
      //   views: x["views"],
      //   comments: [], // Populate if comment data exists
      //   isPoll: x["isPoll"] ?? false,
      //   options: x["options"] == null
      //       ? []
      //       : List<PollOption>.from(x["options"].map((o) => PollOption(
      //     text: o["text"],
      //     votes: o["votes"],
      //   ))),
      //   votedUids: x["votedUids"] == null
      //       ? []
      //       : List<String>.from(x["votedUids"]),
      // ))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "date": date?.toIso8601String(),
      "description": description,
      "location": location,
      "map_url": mapUrl,
      "blocks": blocks.map((b) => b.toJson()).toList(),
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "__v": v,
      "analysis": analysis?.toJson(),
      "posts": posts.map((p) => p.toJson()).toList(),
      "communityPosts": communityPosts.map((p) => p.toJson()).toList(),
    };
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

  factory Analysis.fromJson(Map<String, dynamic> json) {
    return Analysis(
      keywordSentiment: json["keyword_sentiment"] == null
          ? null
          : KeywordSentiment.fromJson(json["keyword_sentiment"]),
      overallSentiment: json["overall_sentiment"] == null
          ? null
          : OverallSentiment.fromJson(json["overall_sentiment"]),
      issuesAndPositives: json["issues_and_positives"] == null
          ? null
          : IssuesAndPositives.fromJson(json["issues_and_positives"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "keyword_sentiment": keywordSentiment?.toJson(),
      "overall_sentiment": overallSentiment?.toJson(),
      "issues_and_positives": issuesAndPositives?.toJson(),
    };
  }
}

class IssuesAndPositives {
  IssuesAndPositives({
    required this.positive,
    required this.negative,
  });

  final List<String> positive;
  final List<String> negative;

  factory IssuesAndPositives.fromJson(Map<String, dynamic> json) {
    return IssuesAndPositives(
      positive: json["positive"] == null
          ? []
          : List<String>.from(json["positive"]!.map((x) => x)),
      negative: json["negative"] == null
          ? []
          : List<String>.from(json["negative"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "positive": positive,
      "negative": negative,
    };
  }
}

class KeywordSentiment {
  KeywordSentiment({
    required this.keywords,
    required this.distribution,
  });

  final List<String> keywords;
  final Map<String, Sentiment> distribution;

  factory KeywordSentiment.fromJson(Map<String, dynamic> json) {
    return KeywordSentiment(
      keywords: json["keywords"] == null
          ? []
          : List<String>.from(json["keywords"].map((x) => x)),
      distribution: json["distribution"] == null
          ? {}
          : Map.from(json["distribution"]).map(
            (k, v) => MapEntry(k, Sentiment.fromJson(v)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "keywords": keywords,
      "distribution":
      distribution.map((k, v) => MapEntry(k, v.toJson())),
    };
  }
}

class Sentiment {
  Sentiment({
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

  factory Sentiment.fromJson(Map<String, dynamic> json) {
    return Sentiment(
      veryPositive: json["very positive"],
      positive: json["positive"],
      neutral: json["neutral"],
      negative: json["negative"],
      veryNegative: json["very negative"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "very positive": veryPositive,
      "positive": positive,
      "neutral": neutral,
      "negative": negative,
      "very negative": veryNegative,
    };
  }
}

class OverallSentiment {
  OverallSentiment({
    required this.overallLabel,
    required this.distribution,
  });

  final String? overallLabel;
  final ConfidenceClass? distribution;

  factory OverallSentiment.fromJson(Map<String, dynamic> json) {
    return OverallSentiment(
      overallLabel: json["overall_label"],
      distribution: json["distribution"] == null
          ? null
          : ConfidenceClass.fromJson(json["distribution"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "overall_label": overallLabel,
      "distribution": distribution?.toJson(),
    };
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

  factory ConfidenceClass.fromJson(Map<String, dynamic> json) {
    return ConfidenceClass(
      positive: json["positive"],
      neutral: json["neutral"],
      negative: json["negative"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "positive": positive,
      "neutral": neutral,
      "negative": negative,
    };
  }
}

class Block {
  Block({
    required this.topLeft,
    required this.bottomRight,
    required this.id,
  });

  final Dimen? topLeft;
  final Dimen? bottomRight;
  final String? id;

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      topLeft: json["topLeft"] == null
          ? null
          : Dimen.fromJson(json["topLeft"]),
      bottomRight: json["bottomRight"] == null
          ? null
          : Dimen.fromJson(json["bottomRight"]),
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "topLeft": topLeft?.toJson(),
      "bottomRight": bottomRight?.toJson(),
      "_id": id,
    };
  }
}

class Dimen {
  Dimen({
    required this.x,
    required this.y,
  });

  final double? x;
  final double? y;

  factory Dimen.fromJson(Map<String, dynamic> json) {
    return Dimen(
      x: (json["x"] as num?)?.toDouble(),
      y: (json["y"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "x": x,
      "y": y,
    };
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

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      platform: json["platform"],
      postId: json["post_id"],
      username: json["username"],
      text: json["text"],
      timestamp: json["timestamp"],
      likes: (json["likes"] as num?)?.toDouble(),
      comments: json["comments"],
      shares: json["shares"],
      url: json["url"],
      sentiment: json["sentiment"] == null
          ? null
          : Sentiment.fromJson(json["sentiment"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "platform": platform,
      "post_id": postId,
      "username": username,
      "text": text,
      "timestamp": timestamp,
      "likes": likes,
      "comments": comments,
      "shares": shares,
      "url": url,
      "sentiment": sentiment?.toJson(),
    };
  }
}

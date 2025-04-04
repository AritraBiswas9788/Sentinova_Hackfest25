class Poll {
  final String question;
  final List<PollOption> options;

  Poll({
    required this.question,
    required this.options,
  });

  Map<String, dynamic> toJson() => {
    'question': question,
    'options': options.map((o) => o.toJson()).toList(),
  };

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
    question: json['question'],
    options: (json['options'] as List)
        .map((o) => PollOption.fromJson(o))
        .toList(),
  );
}

class PollOption {
  final String text;
  int votes;

  PollOption({
    required this.text,
    this.votes = 0,
  });

  Map<String, dynamic> toJson() => {
    'text': text,
    'votes': votes,
  };

  factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
    text: json['text'],
    votes: json['votes'] ?? 0,
  );
}
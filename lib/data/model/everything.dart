import 'dart:convert';

import 'article.dart';

Everything everythingFromJson(String str) => Everything.fromJson(json.decode(str));

String everythingToJson(Everything data) => json.encode(data.toJson());

class Everything {
  String status;
  int totalResults;
  List<Article> articles;

  Everything({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory Everything.fromJson(Map<String, dynamic> json) => Everything(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

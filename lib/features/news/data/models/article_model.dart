import 'package:news/features/news/domain/entities/article.dart';

class ArticleModel extends Article {

  ArticleModel({
    required super.author,
    required super.title,
    required super.desc,
    required super.url,
    required super.image,
    required super.date,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'],
      title: json['title'],
      desc: json['description'],
      url: json['url'],
      image: json['urlToImage'],
      date: json['publishedAt'],
    );
  }
}

import 'package:hive_ce_flutter/adapters.dart';
import 'package:news/features/news/domain/entities/news_entity.dart';

part 'news_model.g.dart';

@HiveType(typeId: 1)
class NewsModel {
  @HiveField(0)
  final String author;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final String date;

  NewsModel({
    required this.author,
    required this.title,
    required this.desc,
    required this.url,
    required this.image,
    required this.date,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'],
      title: json['title'],
      desc: json['description'],
      url: json['url'],
      image: json['urlToImage'],
      date: json['publishedAt'],
    );
  }

  NewsEntity toEntity() {
    return NewsEntity(
      author: author,
      title: title,
      desc: desc,
      url: url,
      image: image,
      date: date,
    );
  }
}

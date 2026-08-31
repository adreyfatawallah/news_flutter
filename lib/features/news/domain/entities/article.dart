import 'package:equatable/equatable.dart';

class Article with Equatable {
  final String author;
  final String title;
  final String desc;
  final String url;
  final String image;
  final String date;

  Article({
    required this.author,
    required this.title,
    required this.desc,
    required this.url,
    required this.image,
    required this.date,
  });

  @override
  List<Object?> get props => [author, title, desc, url, image, date];
}

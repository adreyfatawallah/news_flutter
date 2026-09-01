import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/news/domain/entities/article.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getNews();
}
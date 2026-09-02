import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/news/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getNews();
}
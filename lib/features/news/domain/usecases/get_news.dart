import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/news/domain/entities/article.dart';
import 'package:news/features/news/domain/repositories/news_repository.dart';

class GetNews extends UseCase<List<Article>, NoParam> {

  final NewsRepository _repository;

  GetNews(this._repository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParam params) {
    return _repository.getNews();
  }
}
import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/news/domain/entities/news_entity.dart';
import 'package:news/features/news/domain/repositories/news_repository.dart';

class GetNews extends UseCase<List<NewsEntity>, NoParam> {

  final NewsRepository _repository;

  GetNews(this._repository);

  @override
  Future<Either<Failure, List<NewsEntity>>> call(NoParam params) {
    return _repository.getNews();
  }
}
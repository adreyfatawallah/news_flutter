import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news/features/news/domain/entities/article.dart';
import 'package:news/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  
  final NewsRemoteDataSource _remoteDataSource;

  NewsRepositoryImpl({required this._remoteDataSource});
  
  @override
  Future<Either<Failure, List<Article>>> getNews() async {
    try {
      final result = await _remoteDataSource.getNews();

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/news/data/datasources/news_local_datasource.dart';
import 'package:news/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news/features/news/domain/entities/news_entity.dart';
import 'package:news/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remoteDataSource;
  final NewsLocalDataSource _localDataSource;

  NewsRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
  });

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews() async {
    try {
      final remoteNews = await _remoteDataSource.getNews();
      _localDataSource.saveNews(remoteNews);

      return Right(remoteNews.map((item) => item.toEntity()).toList());
    } catch (e) {
      final error = ServerFailure(e.toString());
      debugPrint('adrey, ${error.toString()}');
      // return Left(ServerFailure(e.toString()));

      try {
        final localNews = _localDataSource.getNews();

        return Right(localNews.map((item) => item.toEntity()).toList());
      } catch (e) {
        return Left(LocalFailure(e.toString()));
      }
    }
  }
}
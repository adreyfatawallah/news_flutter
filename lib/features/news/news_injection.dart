import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import 'package:news/core/network/dio.dart';
import 'package:news/features/news/data/datasources/news_local_datasource.dart';
import 'package:news/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news/features/news/data/models/news/news_model.dart';
import 'package:news/features/news/data/repositories/news_repository_impl.dart';
import 'package:news/features/news/domain/repositories/news_repository.dart';
import 'package:news/features/news/domain/usecases/get_news.dart';
import 'package:news/features/news/presentation/list/cubit/list_cubit.dart';
import 'package:news/injection.dart';

Future<void> newsInjection() async {
  final news = await Hive.openBox<NewsModel>(
    NewsLocalDataSourceImpl.newsBoxName,
  );
  inject.registerLazySingleton<Box<NewsModel>>(() => news);

  inject.registerLazySingleton<Dio>(() => setupDio());

  // datasource
  inject.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(inject()),
  );
  inject.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(inject()),
  );

  // repository
  inject.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: inject(),
      localDataSource: inject(),
    ),
  );

  // usecase
  inject.registerLazySingleton(() => GetNews(inject()));

  // cubit
  inject.registerFactory(() => ListCubit(inject()));
}

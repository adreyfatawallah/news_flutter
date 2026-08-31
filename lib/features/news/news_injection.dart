import 'package:dio/dio.dart';
import 'package:news/config/remote/network.dart';
import 'package:news/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news/features/news/data/repositories/news_repository_impl.dart';
import 'package:news/features/news/domain/repositories/news_repository.dart';
import 'package:news/features/news/domain/usecases/get_news.dart';
import 'package:news/features/news/presentation/list/cubit/list_cubit.dart';
import 'package:news/injection.dart';

void newsInjection() {
  inject.registerLazySingleton<Dio>(() => setupDio());

  // datasource
  inject.registerLazySingleton<NewsRemoteDataSource>(
        () => NewsRemoteDataSourceImpl(inject()),
  );

  // repository
  inject.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(
      remoteDataSource: inject(),
    ),
  );

  // usecase
  inject.registerLazySingleton(() => GetNews(inject()));

  // cubit
  inject.registerFactory(() => ListCubit(inject()));
}

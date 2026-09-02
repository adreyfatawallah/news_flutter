import 'package:dio/dio.dart';
import 'package:news/core/error/exception.dart';
import 'package:news/core/network/api.dart';
import 'package:news/core/network/base_response.dart';
import 'package:news/features/news/data/models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {

  final Dio _dio;

  NewsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ArticleModel>> getNews() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      final result = await _dio.get(
        Api.topHeadlines,
        queryParameters: {
          'sources': 'bbc-news',
          'apiKey': Api.apiKey,
        },
      );

      final response = BaseResponse<List<ArticleModel>>.fromJson(result.data, (json) {
        final rawList = json as List<dynamic>;
        return rawList.map((item) => ArticleModel.fromJson(item)).toList();
      });

      if (response.status == 'ok' && response.data != null) {
        return response.data!.toList();
      }

      return List.empty();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
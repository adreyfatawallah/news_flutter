import 'package:flutter/cupertino.dart';
import 'package:hive_ce/hive.dart';
import 'package:news/core/error/exception.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/news/data/models/news/news_model.dart';

abstract class NewsLocalDataSource {
  Future<void> saveNews(List<NewsModel> news);
  List<NewsModel> getNews();
  Future<void> clearNews();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {

  static const newsBoxName = 'news_box';

  final Box<NewsModel> _news;

  NewsLocalDataSourceImpl(this._news);

  @override
  Future<void> saveNews(List<NewsModel> news) async {
    try {
      final Map<String, NewsModel> newsMap = {
        for (var item in news) item.title: item
      };
      await _news.putAll(newsMap);

      final saveNews = getNews();
      for (var item in saveNews) {
        debugPrint('adrey, news: $item');
      }
    } catch (e) {
      throw LocalException(e.toString());
    }
  }

  @override
  List<NewsModel> getNews() {
    try {
      return _news.values.toList();
    } catch (e) {
      throw LocalException(e.toString());
    }
  }

  @override
  Future<void> clearNews() async {
    try {
      await _news.clear();
    } catch (e) {
      throw LocalException(e.toString());
    }
  }
}
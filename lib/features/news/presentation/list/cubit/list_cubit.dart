import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/news/domain/entities/news_entity.dart';
import 'package:news/features/news/domain/usecases/get_news.dart';

part 'list_cubit.freezed.dart';

@freezed
sealed class ListState with _$ListState {
  const factory ListState.initial() = _Initial;
  const factory ListState.loading() = _Loading;
  const factory ListState.success(List<NewsEntity> news) = _Success;
  const factory ListState.failure() = _Failure;
}

class ListCubit extends Cubit<ListState> {
  final GetNews _getNews;

  ListCubit(this._getNews) : super(const ListState.initial());

  Future<void> getNews() async {
    emit(const ListState.loading());

    final result = await _getNews(NoParam());

    result.fold(
      (failure) {
        emit(const ListState.failure());
      },
      (success) {
        emit(ListState.success(success));
      },
    );
  }
}

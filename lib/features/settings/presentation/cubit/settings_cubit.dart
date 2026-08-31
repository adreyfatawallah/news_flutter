import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news/features/settings/domain/repositories/settings_repository.dart';

part 'settings_cubit.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    required Brightness theme,
    required Locale locale,
    required bool isAuth,
  }) = _SettingsState;
}

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit(this._repository) : super(initial(_repository));

  static SettingsState initial(SettingsRepository repository) {
    final theme =
        repository.getTheme() ??
        PlatformDispatcher.instance.platformBrightness.name;
    final language =
        repository.getLanguage() ??
        PlatformDispatcher.instance.locale.languageCode;

    return SettingsState(
      theme: theme == Brightness.light.name
          ? Brightness.light
          : Brightness.dark,
      locale: Locale(language),
      isAuth: repository.isAuth(),
    );
  }

  void changeLanguage(String language) async {
    await _repository.saveLanguage(language);
    emit(state.copyWith(locale: Locale(language)));
  }

  void changeTheme(Brightness theme) async {
    await _repository.saveTheme(theme.name);
    emit(state.copyWith(theme: theme));
  }

  void setAuth(bool isAuth) async {
    await _repository.setAuth(isAuth);
    emit(state.copyWith(isAuth: isAuth));
  }
}

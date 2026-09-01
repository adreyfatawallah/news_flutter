import 'package:news/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:news/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource _localDatasource;

  SettingsRepositoryImpl({required this._localDatasource});

  @override
  Future<void> changeTheme(String theme) async {
    try {
      await _localDatasource.changeTheme(theme);
    } catch (e) {
      return;
    }
  }

  @override
  String? getTheme() {
    try {
      return _localDatasource.getTheme();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> changeLanguage(String language) async {
    try {
      await _localDatasource.changeLanguage(language);
    } catch (e) {
      return;
    }
  }

  @override
  String? getLanguage() {
    try {
      return _localDatasource.getLanguage();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setAuth(bool isAuth) async {
    try {
      await _localDatasource.setAuth(isAuth);
    } catch (e) {
      return;
    }
  }

  @override
  bool isAuth() {
    try {
      return _localDatasource.isAuth();
    } catch (e) {
      return false;
    }
  }
}

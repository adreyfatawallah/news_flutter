import 'package:news/config/local/database.dart';

abstract class SettingsLocalDatasource {
  Future<void> saveTheme(String theme);
  String? getTheme();
  Future<void> saveLanguage(String language);
  String? getLanguage();
  Future<void> setAuth(bool isAuth);
  bool isAuth();
}

class SettingsLocalDatasourceImpl with BoxMixin implements SettingsLocalDatasource {

  @override
  Future<void> saveTheme(String theme) async {
    try {
      await settingsBox.put(BoxMixin.keyTheme, theme);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  String? getTheme() {
    try {
      return settingsBox.get(BoxMixin.keyTheme, defaultValue: null);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> saveLanguage(String language) async {
    try {
      await settingsBox.put(BoxMixin.keyLanguage, language);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  String? getLanguage() {
    try {
      return settingsBox.get(BoxMixin.keyLanguage, defaultValue: null);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> setAuth(bool isAuth) async {
    try {
      await settingsBox.put(BoxMixin.keyAuth, isAuth);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  bool isAuth() {
    try {
      return settingsBox.get(BoxMixin.keyAuth, defaultValue: false);
    } catch (e) {
      throw Exception(e);
    }
  }
}

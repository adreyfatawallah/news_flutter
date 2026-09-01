import 'package:hive_ce/hive.dart';

abstract class SettingsLocalDatasource {
  Future<void> changeTheme(String theme);
  String? getTheme();
  Future<void> changeLanguage(String language);
  String? getLanguage();
  Future<void> setAuth(bool isAuth);
  bool isAuth();
}

class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {

  static const settingBoxName = 'setting_box';

  static const _keyTheme = 'theme';
  static const _keyLanguage = 'language';
  static const _keyAuth = 'isAuth';

  final Box _settingBox;

  SettingsLocalDatasourceImpl(this._settingBox);

  @override
  Future<void> changeTheme(String theme) async {
    try {
      await _settingBox.put(_keyTheme, theme);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  String? getTheme() {
    try {
      return _settingBox.get(_keyTheme, defaultValue: null);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> changeLanguage(String language) async {
    try {
      await _settingBox.put(_keyLanguage, language);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  String? getLanguage() {
    try {
      return _settingBox.get(_keyLanguage, defaultValue: null);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> setAuth(bool isAuth) async {
    try {
      await _settingBox.put(_keyAuth, isAuth);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  bool isAuth() {
    try {
      return _settingBox.get(_keyAuth, defaultValue: false);
    } catch (e) {
      throw Exception(e);
    }
  }
}

abstract class SettingsRepository {
  Future<void> saveTheme(String theme);
  String? getTheme();
  Future<void> saveLanguage(String language);
  String? getLanguage();
  Future<void> setAuth(bool isAuth);
  bool isAuth();
}
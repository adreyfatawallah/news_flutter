abstract class SettingsRepository {
  Future<void> changeTheme(String theme);
  String? getTheme();
  Future<void> changeLanguage(String language);
  String? getLanguage();
  Future<void> setAuth(bool isAuth);
  bool isAuth();
}
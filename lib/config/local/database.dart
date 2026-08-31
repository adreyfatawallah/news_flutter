import 'package:hive_ce_flutter/adapters.dart';
import 'package:news/features/auth/data/models/user/user_model.dart';
import 'package:news/hive_registrar.g.dart';

mixin BoxMixin {
  static const _usersBoxName = "users_box";
  static const _settingsBoxName = "settings_box";

  static const keyTheme = "theme";
  static const keyLanguage = "language";
  static const keyAuth = "isAuth";

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    await Hive.openBox<UserModel>(_usersBoxName);
    await Hive.openBox(_settingsBoxName);
  }

  Box<UserModel> get usersBox => Hive.box(_usersBoxName);
  Box get settingsBox => Hive.box(_settingsBoxName);
}
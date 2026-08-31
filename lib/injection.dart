import 'package:get_it/get_it.dart';
import 'package:news/features/auth/auth_injection.dart';
import 'package:news/features/news/news_injection.dart';
import 'package:news/features/settings/settings_injection.dart';
import 'package:news/navigation.dart';

final inject = GetIt.instance;

Future<void> setupInjection() async {
  inject.registerLazySingleton(() => Navigation(inject()));

  authInjection();
  newsInjection();
  settingsInjection();
}
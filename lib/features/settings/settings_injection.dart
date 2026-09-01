import 'package:hive_ce/hive.dart';
import 'package:news/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:news/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:news/features/settings/domain/repositories/settings_repository.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:news/injection.dart';

Future<void> settingsInjection() async {
  // database
  final settingsBox = await Hive.openBox(SettingsLocalDatasourceImpl.settingBoxName);
  inject.registerLazySingleton<Box>(() => settingsBox);

  // datasource
  inject.registerLazySingleton<SettingsLocalDatasource>(
        () => SettingsLocalDatasourceImpl(inject()),
  );

  // repository
  inject.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(localDatasource: inject()),
  );

  // cubit
  inject.registerLazySingleton(() => SettingsCubit(inject()));
}
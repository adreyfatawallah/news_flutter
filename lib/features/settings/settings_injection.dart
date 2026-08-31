
import 'package:news/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:news/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:news/features/settings/domain/repositories/settings_repository.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:news/injection.dart';

void settingsInjection() {
  // datasource
  inject.registerLazySingleton<SettingsLocalDatasource>(
        () => SettingsLocalDatasourceImpl(),
  );

  // repository
  inject.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(localDatasource: inject()),
  );

  // cubit
  inject.registerLazySingleton(() => SettingsCubit(inject()));
}
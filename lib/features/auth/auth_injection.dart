import 'package:hive_ce/hive.dart';
import 'package:news/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:news/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:news/features/auth/data/models/user/user_model.dart';
import 'package:news/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:news/features/auth/domain/repositories/auth_repository.dart';
import 'package:news/features/auth/domain/usecases/login.dart';
import 'package:news/features/auth/domain/usecases/post_register.dart';
import 'package:news/features/auth/presentation/screen/login/cubit/login_cubit.dart';
import 'package:news/features/auth/presentation/screen/register/cubit/register_cubit.dart';
import 'package:news/injection.dart';

Future<void> authInjection() async {
  // database
  final userBox = await Hive.openBox<UserModel>(AuthLocalDataSourceImpl.userBoxName);
  inject.registerLazySingleton<Box<UserModel>>(() => userBox);

  // datasource
  inject.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );
  inject.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(inject()),
  );

  // repository
  inject.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: inject(),
      localDataSource: inject(),
    ),
  );

  // usecase
  inject.registerLazySingleton(() => Login(inject()));
  inject.registerLazySingleton(() => PostRegister(inject()));

  // cubit
  inject.registerFactory(() => LoginCubit(inject()));
  inject.registerFactory(() => RegisterCubit(inject()));
}

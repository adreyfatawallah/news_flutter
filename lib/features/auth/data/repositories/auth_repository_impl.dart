import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/core/utils/error/failure.dart';
import 'package:news/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:news/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:news/features/auth/domain/repositories/auth_repository.dart';
import 'package:news/features/auth/domain/usecases/post_login.dart';
import 'package:news/features/auth/domain/usecases/post_register.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
  });

  @override
  Future<Either<Failure, bool>> login(LoginParams params) async {
    // Example from remote data source
    // try {
    //   final result = await _remoteDataSource.postLogin(params);
    //
    //   return Right(LoginModel(isSuccess: result.isSuccess));
    // } catch (e) {
    //   return Left(ServerFailure(e.toString()));
    // }

    // Example from local data source
    try {
      final result = await _localDataSource.loginUser(params);

      return Right(result != null);
    } catch (e) {
      return Left(LocalFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUser(RegisterParams params) async {
    try {
      final isUserExist = _localDataSource.getUser(params.username);

      if (isUserExist == null) {
        await _localDataSource.saveUser(params);

        _localDataSource.getUsers().forEach((user) {
          debugPrint(
            "adrey, username: ${user.username} - password: ${user.password}",
          );
        });

        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(LocalFailure(e.toString()));
    }
  }
}

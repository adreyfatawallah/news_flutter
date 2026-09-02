import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:news/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:news/features/auth/data/models/register_model.dart';
import 'package:news/features/auth/domain/entities/login_entity.dart';
import 'package:news/features/auth/domain/entities/register_entity.dart';
import 'package:news/features/auth/domain/repositories/auth_repository.dart';
import 'package:news/features/auth/domain/usecases/login.dart';
import 'package:news/features/auth/domain/usecases/register.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required this._remoteDataSource,
    required this._localDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
    // Example from remote data source
    // try {
    //   final responseLogin = await _remoteDataSource.login(params);
    //
    //   return Right(responseLogin);
    // } catch (e) {
    //   return Left(ServerFailure(e.toString()));
    // }

    // Example from local data source
    try {
      final responseLogin = await _localDataSource.login(params);

      return Right(responseLogin);
    } catch (e) {
      return Left(LocalFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(RegisterParams params) async {
    try {
      final isUserExist = _localDataSource.getUser(params.username);

      if (isUserExist != null) {
        return Right(RegisterModel(isSuccess: false));
      }

      await _localDataSource.saveUser(params);

      _localDataSource.getUsers().forEach((user) {
        debugPrint(
          'adrey, username: ${user.username} - password: ${user.password}',
        );
      });

      return Right(RegisterModel(isSuccess: true));
    } catch (e) {
      return Left(LocalFailure(e.toString()));
    }
  }
}

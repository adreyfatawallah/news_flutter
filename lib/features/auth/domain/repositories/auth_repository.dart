import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/features/auth/domain/entities/login_entity.dart';
import 'package:news/features/auth/domain/usecases/login.dart';
import 'package:news/features/auth/domain/usecases/post_register.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
  Future<Either<Failure, bool>> saveUser(RegisterParams params);
}

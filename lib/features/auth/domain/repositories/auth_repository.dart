import 'package:dartz/dartz.dart';
import 'package:news/core/utils/error/failure.dart';
import 'package:news/features/auth/domain/usecases/post_login.dart';
import 'package:news/features/auth/domain/usecases/post_register.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(LoginParams params);
  Future<Either<Failure, bool>> saveUser(RegisterParams params);
}

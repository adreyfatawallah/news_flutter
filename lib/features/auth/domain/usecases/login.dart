import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/auth/domain/entities/login_entity.dart';
import 'package:news/features/auth/domain/repositories/auth_repository.dart';

class Login implements UseCase<LoginEntity, LoginParams> {
  final AuthRepository _repository;

  Login(this._repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await _repository.login(params);
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

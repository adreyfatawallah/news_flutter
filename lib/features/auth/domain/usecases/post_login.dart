import 'package:dartz/dartz.dart';
import 'package:news/core/utils/error/failure.dart';
import 'package:news/core/utils/usecase/usecase.dart';
import 'package:news/features/auth/domain/repositories/auth_repository.dart';

class PostLogin implements UseCase<bool, LoginParams> {
  final AuthRepository _repository;

  PostLogin(this._repository);

  @override
  Future<Either<Failure, bool>> call(LoginParams params) async {
    return await _repository.login(params);
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

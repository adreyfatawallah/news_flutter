import 'package:dartz/dartz.dart';
import 'package:news/core/utils/error/failure.dart';
import 'package:news/core/utils/mixin/validation_mixin.dart';
import 'package:news/core/utils/usecase/usecase.dart';
import 'package:news/features/auth/domain/repositories/auth_repository.dart';

class PostRegister with ValidationMixin implements UseCase<bool, RegisterParams> {
  final AuthRepository _repository;

  PostRegister(this._repository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await _repository.saveUser(params);
  }
}

class RegisterParams {
  final String username;
  final String password;

  RegisterParams({required this.username, required this.password});
}

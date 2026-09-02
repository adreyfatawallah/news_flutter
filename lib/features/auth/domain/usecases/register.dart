import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/utils/mixin/validation_mixin.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/features/auth/domain/entities/register_entity.dart';
import 'package:news/features/auth/domain/repositories/auth_repository.dart';

class Register with ValidationMixin implements UseCase<RegisterEntity, RegisterParams> {
  final AuthRepository _repository;

  Register(this._repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) async {
    return await _repository.register(params);
  }
}

class RegisterParams {
  final String username;
  final String password;

  RegisterParams({required this.username, required this.password});
}

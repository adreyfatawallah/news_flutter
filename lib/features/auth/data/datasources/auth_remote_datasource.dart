import 'package:news/core/error/exception.dart';
import 'package:news/core/utils/const.dart';
import 'package:news/features/auth/data/models/login_model.dart';
import 'package:news/features/auth/domain/usecases/login.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login(LoginParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  @override
  Future<LoginModel> login(LoginParams params) async {
    await Future.delayed(const Duration(seconds: 2));

    final username = params.username;
    final password = params.password;

    if (username == 'q' && password == 'q') {
      throw ServerException(MyConst.errorServerFailure);
    }

    return LoginModel(isSuccess: username == 'adrey' && password == 'adrey');
  }
}

import 'package:news/core/utils/const.dart';
import 'package:news/features/auth/domain/usecases/post_login.dart';

abstract class AuthRemoteDataSource {
  Future<bool> postLogin(LoginParams params);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  @override
  Future<bool> postLogin(LoginParams params) async {
    await Future.delayed(const Duration(seconds: 3));

    final username = params.username;
    final password = params.password;

    if (username == "q" && password == "q") {
      throw Exception(MyConst.errorServerFailure);
    }

    return username == "adrey" && password == "adrey";
  }
}

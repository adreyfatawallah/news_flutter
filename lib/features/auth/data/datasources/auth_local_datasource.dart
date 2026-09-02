import 'package:hive_ce/hive.dart';
import 'package:news/core/error/exception.dart';
import 'package:news/features/auth/data/models/login_model.dart';
import 'package:news/features/auth/data/models/user/user_model.dart';
import 'package:news/features/auth/domain/usecases/login.dart';
import 'package:news/features/auth/domain/usecases/register.dart';
import 'package:uuid/uuid.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(RegisterParams params);
  UserModel? getUser(String username);
  Future<LoginModel> login(LoginParams params);
  List<UserModel> getUsers();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  static const userBoxName = 'user_box';

  final Box<UserModel> _userBox;

  AuthLocalDataSourceImpl(this._userBox);

  @override
  Future<void> saveUser(RegisterParams params) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final id = const Uuid().v4();
      final username = params.username;
      final password = params.password;

      await _userBox.put(
        username,
        UserModel(id: id, username: username, password: password),
      );
    } catch (e) {
      throw LocalException(e.toString());
    }
  }

  @override
  UserModel? getUser(String username) {
    try {
      return _userBox.get(username);
    } catch (e) {
      throw LocalException(e.toString());
    }
  }

  @override
  Future<LoginModel> login(LoginParams params) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final username = params.username;
      final password = params.password;

      final user = _userBox.get(username);
      if (user == null) {
        return LoginModel(isSuccess: false);
      }

      if (user.password != password) {
        return LoginModel(isSuccess: false);
      }

      return LoginModel(isSuccess: true);
    } catch (e) {
      throw LocalException(e.toString());
    }
  }

  @override
  List<UserModel> getUsers() {
    try {
      return _userBox.values.toList();
    } catch (e) {
      throw LocalException(e.toString());
    }
  }
}

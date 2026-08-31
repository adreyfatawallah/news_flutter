import 'package:news/config/local/database.dart';
import 'package:news/features/auth/data/models/user/user_model.dart';
import 'package:news/features/auth/domain/usecases/post_login.dart';
import 'package:news/features/auth/domain/usecases/post_register.dart';
import 'package:uuid/uuid.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(RegisterParams params);
  UserModel? getUser(String username);
  Future<UserModel?> loginUser(LoginParams params);
  List<UserModel> getUsers();
}

class AuthLocalDataSourceImpl with BoxMixin implements AuthLocalDataSource {

  @override
  Future<void> saveUser(RegisterParams params) async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      final id = const Uuid().v4();
      final username = params.username;
      final password = params.password;

      await usersBox.put(
        username,
        UserModel(id: id, username: username, password: password),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  UserModel? getUser(String username) {
    try {
      return usersBox.get(username);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel?> loginUser(LoginParams params) async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      final username = params.username;
      final password = params.password;

      final user = usersBox.get(username);
      return user != null
          ? user.password == password
                ? user
                : null
          : null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  List<UserModel> getUsers() {
    try {
      return usersBox.values.toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

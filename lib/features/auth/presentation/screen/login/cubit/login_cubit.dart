import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news/features/auth/domain/usecases/post_login.dart';

part 'login_cubit.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(bool result) = _Success;
  const factory LoginState.failure() = _Failure;
}

class LoginCubit extends Cubit<LoginState> {
  final PostLogin _postLogin;

  LoginCubit(this._postLogin) : super(const LoginState.initial());

  Future<void> login(LoginParams params) async {
    emit(const LoginState.loading());

    final result = await _postLogin(params);

    result.fold(
      (failure) => emit(const LoginState.failure()),
      (success) => emit(LoginState.success(success)),
    );
  }

  void resetState() {
    emit(const LoginState.initial());
  }
}

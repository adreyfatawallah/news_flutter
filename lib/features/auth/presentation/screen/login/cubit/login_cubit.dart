import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news/features/auth/domain/entities/login_entity.dart';
import 'package:news/features/auth/domain/usecases/login.dart';

part 'login_cubit.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(LoginEntity loginEntity) = _Success;
  const factory LoginState.failure() = _Failure;
}

class LoginCubit extends Cubit<LoginState> {
  final Login _login;

  LoginCubit(this._login) : super(const LoginState.initial());

  Future<void> login(LoginParams params) async {
    emit(const LoginState.loading());

    final result = await _login(params);

    result.fold(
      (failure) => emit(const LoginState.failure()),
      (success) => emit(LoginState.success(success)),
    );
  }

  void resetState() {
    emit(const LoginState.initial());
  }
}

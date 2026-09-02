import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news/features/auth/domain/entities/register_entity.dart';
import 'package:news/features/auth/domain/usecases/register.dart';

part 'register_cubit.freezed.dart';

@freezed
sealed class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.loading() = _Loading;
  const factory RegisterState.success(RegisterEntity registerEntity) = _Success;
  const factory RegisterState.failure() = _Failure;
}

class RegisterCubit extends Cubit<RegisterState> {
  final Register _register;

  RegisterCubit(this._register)
    : super(const RegisterState.initial());

  void register(RegisterParams params) async {
    emit(const RegisterState.loading());

    final result = await _register(params);

    result.fold(
      (failure) => emit(const RegisterState.failure()),
      (success) => emit(RegisterState.success(success)),
    );
  }

  void resetState() {
    emit(const RegisterState.initial());
  }
}

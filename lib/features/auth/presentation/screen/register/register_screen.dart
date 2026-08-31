import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/resources/styles/text_field_style.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/core/utils/mixin/validation_mixin.dart';
import 'package:news/core/widgets/filled_button.dart';
import 'package:news/core/widgets/loading_dialog.dart';
import 'package:news/core/widgets/top_notification.dart';
import 'package:news/features/auth/domain/usecases/post_register.dart';
import 'package:news/features/auth/presentation/screen/register/cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _isObscurePassword = ValueNotifier(true);
  final _isObscureConfirmPassword = ValueNotifier(true);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _isObscurePassword.dispose();
    _isObscureConfirmPassword.dispose();

    super.dispose();
  }

  void _onRegisterResult(
    BuildContext context, {
    bool isSuccess = false,
    bool isFailure = false,
  }) {
    LoadingDialog.hide(context);
    TopNotification.show(
      context,
      isFailure
          ? context.getString.msg_server_failure
          : isSuccess
          ? context.getString.msg_register_success
          : context.getString.msg_register_failure,
      isError: !isSuccess,
      onDismiss: () {
        context.read<RegisterCubit>().resetState();
        if (isSuccess) {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () => LoadingDialog.show(context),
            success: (isSuccess) =>
                _onRegisterResult(context, isSuccess: isSuccess),
            failure: () => _onRegisterResult(context, isFailure: true),
            orElse: () {},
          );
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: .symmetric(vertical: 16.h, horizontal: 36.w),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Center(
                  child: Text(
                    context.getString.btn_register,
                    style: context.textTheme.headlineMedium,
                  ),
                ),
                20.verticalSpace,
                Text(
                  context.getString.lbl_username,
                  style: context.textTheme.labelLarge,
                ),
                4.verticalSpace,
                TextFormField(
                  controller: _usernameController,
                  keyboardType: .name,
                  decoration: InputDecoration(
                    hintText: context.getString.hint_username,
                    border: MyTextFieldStyle.textFieldBorder,
                  ),
                  validator: (value) => validateUsername(context, value),
                ),
                12.verticalSpace,
                Text(
                  context.getString.lbl_password,
                  style: context.textTheme.labelLarge,
                ),
                4.verticalSpace,
                ValueListenableBuilder(
                  valueListenable: _isObscurePassword,
                  builder: (context, isObscure, child) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: .visiblePassword,
                      obscureText: _isObscurePassword.value,
                      validator: (value) => validatePassword(context, value),
                      decoration: InputDecoration(
                        hintText: context.getString.hint_password,
                        border: MyTextFieldStyle.textFieldBorder,
                        suffixIcon: IconButton(
                          onPressed: () => _isObscurePassword.value =
                              !_isObscurePassword.value,
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                12.verticalSpace,
                Text(
                  context.getString.lbl_confirm_password,
                  style: context.textTheme.labelLarge,
                ),
                4.verticalSpace,
                ValueListenableBuilder(
                  valueListenable: _isObscureConfirmPassword,
                  builder: (context, isObscure, child) {
                    return TextFormField(
                      controller: _confirmPasswordController,
                      keyboardType: .visiblePassword,
                      obscureText: _isObscureConfirmPassword.value,
                      validator: (value) => validateConfirmPassword(
                        context,
                        _passwordController.text,
                        value,
                      ),
                      decoration: InputDecoration(
                        hintText: context.getString.hint_password,
                        border: MyTextFieldStyle.textFieldBorder,
                        suffixIcon: IconButton(
                          onPressed: () => _isObscureConfirmPassword.value =
                              !_isObscureConfirmPassword.value,
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                24.verticalSpace,
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    final action = state == const RegisterState.initial()
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              context.read<RegisterCubit>().register(
                                RegisterParams(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          }
                        : null;

                    return MyFilledButton(
                      label: context.getString.btn_register,
                      isFillMaxWidth: true,
                      onPressed: action,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

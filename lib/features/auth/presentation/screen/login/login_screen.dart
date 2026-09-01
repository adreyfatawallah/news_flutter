import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/resources/styles/text_field_style.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/core/widgets/filled_button.dart';
import 'package:news/core/widgets/loading_dialog.dart';
import 'package:news/core/widgets/outlined_button.dart';
import 'package:news/core/widgets/top_notification.dart';
import 'package:news/features/auth/domain/usecases/login.dart';
import 'package:news/features/auth/presentation/screen/login/cubit/login_cubit.dart';
import 'package:news/features/auth/presentation/widgets/language_widget.dart';
import 'package:news/features/auth/presentation/widgets/toggle_theme.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:news/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usernameFocus = FocusNode();

  final _isObscurePassword = ValueNotifier(true);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    _usernameFocus.dispose();

    _isObscurePassword.dispose();

    super.dispose();
  }

  void _onLoginResult(
    BuildContext context, {
    bool isSuccess = false,
    bool isFailure = false,
  }) {
    LoadingDialog.hide(context);

    if (isSuccess) {
      context.read<SettingsCubit>().setAuth(true);
    }

    TopNotification.show(
      context,
      isFailure
          ? context.getString.msg_server_failure
          : isSuccess
          ? context.getString.msg_login_success(_usernameController.text)
          : context.getString.msg_login_failure,
      isError: !isSuccess,
      onDismiss: () {
        context.read<LoginCubit>().resetState();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () => LoadingDialog.show(context),
            success: (login) =>
                _onLoginResult(context, isSuccess: login.isSuccess),
            failure: () => _onLoginResult(context, isFailure: true),
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Padding(
            padding: .symmetric(horizontal: 36.w, vertical: 16.h),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [LanguageWidget(), ToggleTheme()],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Center(
                        child: Text(
                          context.getString.lbl_welcome,
                          style: context.textTheme.displaySmall,
                        ),
                      ),
                      20.verticalSpace,
                      Text(
                        context.getString.lbl_username,
                        style: context.textTheme.labelLarge,
                      ),
                      4.verticalSpace,
                      TextField(
                        focusNode: _usernameFocus,
                        controller: _usernameController,
                        keyboardType: .name,
                        decoration: InputDecoration(
                          hintText: context.getString.hint_username,
                          border: MyTextFieldStyle.textFieldBorder,
                        ),
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
                          return TextField(
                            controller: _passwordController,
                            keyboardType: .visiblePassword,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              hintText: context.getString.hint_password,
                              border: MyTextFieldStyle.textFieldBorder,
                              suffixIcon: IconButton(
                                onPressed: () => _isObscurePassword.value =
                                    !_isObscurePassword.value,
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      20.verticalSpace,
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return ListenableBuilder(
                            listenable: Listenable.merge([
                              _usernameController,
                              _passwordController,
                            ]),
                            builder: (context, child) {
                              final isUsernameEmpty = _usernameController.text
                                  .trim()
                                  .isEmpty;
                              final isPasswordEmpty = _passwordController.text
                                  .trim()
                                  .isEmpty;
                              final isFormInValid =
                                  isUsernameEmpty || isPasswordEmpty;

                              final actionLogin =
                                  isFormInValid ||
                                      state != const LoginState.initial()
                                  ? null
                                  : () {
                                      context.read<LoginCubit>().login(
                                        LoginParams(
                                          username: _usernameController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    };

                              return MyOutlinedButton(
                                label: context.getString.btn_login,
                                isFillMaxWidth: true,
                                onPressed: actionLogin,
                              );
                            },
                          );
                        },
                      ),
                      16.verticalSpace,
                      MyFilledButton(
                        label: context.getString.btn_register,
                        onPressed: () {
                          _usernameController.clear();
                          _passwordController.clear();

                          _usernameFocus.requestFocus();

                          context.push(Nav.register.path);
                        },
                        isFillMaxWidth: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

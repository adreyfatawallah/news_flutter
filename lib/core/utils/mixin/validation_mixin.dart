import 'package:flutter/material.dart';
import 'package:news/core/utils/ext/context_ext.dart';

mixin ValidationMixin {
  bool isUsernameNotValid(String username) => username.trim().length < 3;

  bool isPasswordNotValid(String password) => password.trim().length < 5;

  String? validateUsername(BuildContext context, String? username) {
    if (username == null || username.isEmpty) {
      return context.getString.msg_username_empty;
    }
    if (isUsernameNotValid(username)) {
      return context.getString.msg_username_not_valid;
    }
    return null;
  }

  String? validatePassword(BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return context.getString.msg_password_empty;
    }
    if (isPasswordNotValid(password)) {
      return context.getString.msg_password_not_valid;
    }
    return null;
  }

  String? validateConfirmPassword(
    BuildContext context,
    String password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return context.getString.msg_password_empty;
    }
    if (password != confirmPassword) {
      return context.getString.msg_confim_password_not_match;
    }
    return null;
  }
}

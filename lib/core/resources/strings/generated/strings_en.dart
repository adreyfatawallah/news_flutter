// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class StringsEn extends Strings {
  StringsEn([String locale = 'en']) : super(locale);

  @override
  String get lbl_english => 'English';

  @override
  String get lbl_indonesia => 'Indonesia';

  @override
  String get lbl_language => 'Language:';

  @override
  String get lbl_theme => 'Theme:';

  @override
  String get lbl_welcome => 'Welcome';

  @override
  String get lbl_username => 'Username';

  @override
  String get lbl_password => 'Password';

  @override
  String get lbl_confirm_password => 'Confirm Password';

  @override
  String get lbl_please_wait => 'Please wait...';

  @override
  String get hint_username => 'Enter Username';

  @override
  String get hint_password => 'Enter Password';

  @override
  String get btn_login => 'Login';

  @override
  String get btn_register => 'Register';

  @override
  String get msg_username_empty => 'Username is empty';

  @override
  String get msg_username_not_valid => 'Username must be at least 3 characters';

  @override
  String get msg_password_empty => 'Password is empty';

  @override
  String get msg_password_not_valid => 'Password must be at least 5 characters';

  @override
  String get msg_confim_password_empty => 'Confirm password empty';

  @override
  String get msg_confim_password_not_match => 'Password not match';

  @override
  String get msg_server_failure => 'Server failure';

  @override
  String msg_login_success(String username) {
    return 'Welcome $username...';
  }

  @override
  String get msg_login_failure => 'Username or password does not match';

  @override
  String get msg_register_success => 'Register success';

  @override
  String get msg_register_failure => 'Username already exist';
}

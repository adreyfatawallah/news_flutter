// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class StringsId extends Strings {
  StringsId([String locale = 'id']) : super(locale);

  @override
  String get lbl_english => 'Inggris';

  @override
  String get lbl_indonesia => 'Indonesia';

  @override
  String get lbl_language => 'Bahasa:';

  @override
  String get lbl_theme => 'Tema:';

  @override
  String get lbl_welcome => 'Selamat Datang';

  @override
  String get lbl_username => 'Nama Pengguna';

  @override
  String get lbl_password => 'Kata Sandi';

  @override
  String get lbl_confirm_password => 'Konfirmasi Kata Sandi';

  @override
  String get lbl_please_wait => 'Harap tunggu...';

  @override
  String get hint_username => 'Masukkan Nama Pengguna';

  @override
  String get hint_password => 'Masukkan Kata Sandi';

  @override
  String get btn_login => 'Masuk';

  @override
  String get btn_register => 'Daftar';

  @override
  String get msg_username_empty => 'Nama pengguna kosong';

  @override
  String get msg_username_not_valid => 'Nama pengguna minimal 3 karakter';

  @override
  String get msg_password_empty => 'Kata sandi kosong';

  @override
  String get msg_password_not_valid => 'Kata sandi minimal 5 karakter';

  @override
  String get msg_confim_password_empty => 'Konfirmasi kata sandi kosong';

  @override
  String get msg_confim_password_not_match => 'Kata sandi tidak sesuai';

  @override
  String get msg_server_failure => 'Gagal terhubung ke server';

  @override
  String msg_login_success(String username) {
    return 'Selamat datang $username...';
  }

  @override
  String get msg_login_failure => 'Nama pengguna atau kata sandi tidak sesuai';

  @override
  String get msg_register_success => 'Daftar berhasil';

  @override
  String get msg_register_failure => 'Nama pengguna sudah terdaftar';
}

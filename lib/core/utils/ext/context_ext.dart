import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/core/resources/strings/generated/strings.dart';

extension ContextExt on BuildContext {
  Strings get getString => Strings.of(this)!;

  Locale get currentLocale => Localizations.localeOf(this);

  Brightness get theme => Theme.of(this).brightness;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get screenSize => MediaQuery.of(this).size;
  
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  String formatDate(String date) {
    try {
      final dateTime = DateTime.parse(date);
      return DateFormat.yMMMMd(Localizations.localeOf(this).toString())
          .format(dateTime);
    } catch (e) {
      return date;
    }
  }
}

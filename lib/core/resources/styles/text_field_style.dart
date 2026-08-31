import 'package:flutter/material.dart';
import 'package:news/core/resources/dimens.dart';

class MyTextFieldStyle {
  MyTextFieldStyle._();

  static OutlineInputBorder textFieldBorder =  OutlineInputBorder(
    borderRadius: .circular(MyDimens.radiusTextField),
  );
}
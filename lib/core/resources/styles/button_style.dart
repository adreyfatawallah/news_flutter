import 'package:flutter/material.dart';
import 'package:news/core/resources/dimens.dart';

class MyButtonStyle {
  MyButtonStyle._();

  static OutlinedBorder buttonShape = RoundedRectangleBorder(
    borderRadius: .circular(MyDimens.radiusButton),
  );
}
import 'package:flutter/material.dart';
import 'package:news/core/resources/dimens.dart';
import 'package:news/core/resources/styles/button_style.dart';

class MyFilledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isFillMaxWidth;

  const MyFilledButton({
    super.key,
    this.onPressed,
    this.isFillMaxWidth = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFillMaxWidth ? double.infinity : null,
      height: MyDimens.heightButton,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(shape: MyButtonStyle.buttonShape),
        child: Text(label),
      ),
    );
  }
}

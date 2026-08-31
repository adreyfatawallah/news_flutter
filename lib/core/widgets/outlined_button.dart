import 'package:flutter/material.dart';
import 'package:news/core/resources/dimens.dart';
import 'package:news/core/resources/styles/button_style.dart';

class MyOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isFillMaxWidth;

  const MyOutlinedButton({
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
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(shape: MyButtonStyle.buttonShape),
        child: Text(label),
      ),
    );
  }
}

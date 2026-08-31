import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/resources/dimens.dart';
import 'package:news/core/utils/ext/context_ext.dart';

class LoadingDialog {
  LoadingDialog._();

  static void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: .circular(MyDimens.borderRadius),
            ),
            content: Column(
              mainAxisSize: .min,
              children: [
                10.verticalSpace,
                const CircularProgressIndicator(),
                10.verticalSpace,
                Text(message ?? context.getString.lbl_please_wait),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}

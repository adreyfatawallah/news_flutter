import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';

class ToggleTheme extends StatelessWidget {
  const ToggleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = 14.r;

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: .min,
        children: [
          Text(
            context.getString.lbl_theme,
            style: context.textTheme.labelMedium,
          ),
          4.horizontalSpace,
          InkWell(
            onTap: () =>
                context.read<SettingsCubit>().changeTheme(Brightness.light),
            child: context.theme == Brightness.light
                ? Icon(Icons.light_mode, size: iconSize)
                : Icon(Icons.light_mode_outlined, size: iconSize),
          ),
          const VerticalDivider(),
          InkWell(
            onTap: () =>
                context.read<SettingsCubit>().changeTheme(Brightness.dark),
            child: context.theme == Brightness.dark
                ? Icon(Icons.dark_mode, size: iconSize)
                : Icon(Icons.dark_mode_outlined, size: iconSize),
          ),
        ],
      ),
    );
  }
}

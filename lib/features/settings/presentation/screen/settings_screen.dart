import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/resources/dimens.dart';
import 'package:news/core/resources/icons.dart';
import 'package:news/core/resources/styles/button_style.dart';
import 'package:news/core/utils/const.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/core/widgets/language_widget.dart';
import 'package:news/features/auth/domain/entities/item_language.dart';
import 'package:news/core/widgets/toggle_theme.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listLanguage = [
      ItemLanguage(
        value: MyConst.langCodeEn,
        flag: MyIcons.getFlag('en'),
        label: context.getString.lbl_english,
      ),
      ItemLanguage(
        value: MyConst.langCodeId,
        flag: MyIcons.getFlag('id'),
        label: context.getString.lbl_indonesia,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(context.getString.lbl_setting),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: .all(16.r),
                      child: Row(
                        children: [
                          Text(
                            context.getString.lbl_language,
                            style: context.textTheme.labelLarge,
                          ),
                          const Spacer(),
                          LanguageWidget(
                            child: SvgPicture.asset(
                              MyIcons.getFlag(
                                context.currentLocale.languageCode,
                              ),
                              width: 16.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: .all(16.r),
                      child: Row(
                        children: [
                          Text(
                            context.getString.lbl_theme,
                            style: context.textTheme.labelLarge,
                          ),
                          const Spacer(),
                          ToggleTheme(
                            useLabel: false,
                            iconSize: 18.r,
                            spaceBetween: 10.w,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: .symmetric(horizontal: 16.w),
            child: SizedBox(
              width: .infinity,
              height: MyDimens.heightButton,
              child: OutlinedButton(
                onPressed: () => _showLogoutDialog(context),
                style: OutlinedButton.styleFrom(
                  shape: MyButtonStyle.buttonShape,
                  side: BorderSide(color: context.colorScheme.error),
                  foregroundColor: context.colorScheme.error,
                ),
                child: Text(context.getString.btn_logout),
              ),
            ),
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(context.getString.btn_logout),
          content: Text(context.getString.msg_logout),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(context.getString.btn_cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<SettingsCubit>().setAuth(false);
              },
              child: Text(
                context.getString.btn_logout,
                style: TextStyle(color: context.colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }
}

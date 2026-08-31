import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/resources/dimens.dart';
import 'package:news/core/resources/icons.dart';
import 'package:news/core/resources/strings/generated/strings.dart';
import 'package:news/core/utils/const.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:news/features/auth/domain/entities/item_language.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    final listLanguage = [
      ItemLanguage(
        value: MyConst.langCodeEn,
        icon: MyIcons.getFlag("en"),
        label: context.getString.lbl_english,
      ),
      ItemLanguage(
        value: MyConst.langCodeId,
        icon: MyIcons.getFlag("id"),
        label: context.getString.lbl_indonesia,
      ),
    ];

    return PopupMenuButton(
      position: .under,
      padding: .zero,
      menuPadding: .zero,
      constraints: const BoxConstraints(minWidth: 0),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(MyDimens.borderRadius),
      ),
      onSelected: (value) {
        final updateLocale = Locale(value);
        if (Strings.supportedLocales.contains(updateLocale)) {
          context.read<SettingsCubit>().changeLanguage(value);
        }
      },
      itemBuilder: (context) => List.generate(
        listLanguage.length,
        (index) => PopupMenuItem<String>(
          value: listLanguage[index].value,
          child: Row(
            mainAxisSize: .min,
            children: [
              SvgPicture.asset(listLanguage[index].icon),
              8.horizontalSpace,
              Text(listLanguage[index].label),
            ],
          ),
        ),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Text(
            context.getString.lbl_language,
            style: context.textTheme.labelMedium,
          ),
          4.horizontalSpace,
          SvgPicture.asset(MyIcons.getFlag(langCode)),
        ],
      ),
    );
  }
}

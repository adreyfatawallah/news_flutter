import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/core/resources/strings/generated/strings.dart';
import 'package:news/core/resources/theme.dart';
import 'package:news/core/utils/const.dart';
import 'package:news/core/utils/util.dart';
import 'package:news/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:news/navigation.dart';

class MyApp extends StatelessWidget {
  final SettingsCubit settingsCubit;
  final Navigation navigation;

  const MyApp({
    super.key,
    required this.settingsCubit,
    required this.navigation,
  });

  @override
  Widget build(BuildContext context) {
    // Get theme device
    // final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [BlocProvider.value(value: settingsCubit)],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settings) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: MyConst.appName,
                localizationsDelegates: const [
                  Strings.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: Strings.supportedLocales,
                locale: settings.locale,
                theme: settings.theme == Brightness.light
                    ? theme.light()
                    : theme.dark(),
                routerConfig: navigation.router,
              );
            },
          );
        },
      ),
    );
  }
}

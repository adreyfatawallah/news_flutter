import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/config/local/database.dart';
import 'package:news/injection.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BoxMixin.init();

  await setupInjection();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(MyApp(settingsCubit: inject(), navigation: inject()));
  });
}

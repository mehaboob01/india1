import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';

import 'localization/locale_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'India One',
      debugShowCheckedModeBanner: false,
      locale: Locale('en', 'US'),
      translations: LocaleString(),
      onGenerateRoute: MRouter.generateRoute,
      initialRoute: MRouter.splashRoute,
    );
  }
}

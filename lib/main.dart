import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';

import 'localization/locale_string.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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

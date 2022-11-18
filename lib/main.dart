import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';

import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/connection_lost.dart';

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
    return InternetWidget(
      online: GetMaterialApp(
        title: 'India One',
        debugShowCheckedModeBanner: false,
        locale: Locale('en', 'US'),
        translations: LocaleString(),
        onGenerateRoute: MRouter.generateRoute,
        initialRoute: MRouter.splashRoute,
      ),
      offline: ConnectionLost(),
    );
  }
}

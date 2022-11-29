import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/no_internet_ui/no_internet_ui.dart';
import 'package:india_one/screens/helpers/version_validator.dart';

import 'localization/locale_string.dart';

//
// Receive Message/Notifications when app is in BG

// Future<void> backgroundHandler(RemoteMessage message) async {
//   LocalNotificationService.initialize();
//
//   print("background");
//   print(message.data.toString());
//   print(message.notification!.title.toString());
//   LocalNotificationService.display(message);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        // LocalNotificationService.display(message);
        print("background but opend");
        final routeFromMessage = message.data["route"];
        //  Get.toNamed(routeFromMessage);
      }
    });

    // // notifications data when app is on foreground
    FirebaseMessaging.onMessage.listen((messsage) {
      if (messsage.notification != null) {
        print(messsage.notification!.body);
        print(messsage.notification!.title);
        //  LocalNotificationService.display(messsage);
      }
    });

    // when app is open but in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // LocalNotificationService.display(message);
      print("background but opend");
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

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
      offline: NoInternet(),
    );
  }
}

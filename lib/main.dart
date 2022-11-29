import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/no_internet_ui/no_internet_ui.dart';

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
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
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
    FirebaseMessaging.instance.getInitialMessage().then((message){

      if(message!=null)
      {
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

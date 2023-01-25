import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/popUps_page.dart';
import 'package:india_one/screens/helpers/no_internet.dart';
import 'package:india_one/services/local_notifications_service.dart';

import 'connection_manager/connection_binding.dart';
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

  // for notification
  await Firebase.initializeApp();

  initializeNotification();

  // for firebase analytics

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.

// Get a specific camera from the list of available cameras.

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
    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   if (message != null) {
    //      LocalNotificationService.display(message);
    //     print("background but opend");
    //     final routeFromMessage = message.data["route"];
    //     //  Get.toNamed(routeFromMessage);
    //   }
    // });

    // // notifications data when app is on foreground
    FirebaseMessaging.onMessage.listen((messsage) {
      if (messsage.notification != null) {
        print("for");
        print(messsage.notification!.body);
        print(messsage.notification!.title);
        LocalNotificationService.display(messsage);
      }
    });

    // when app is open but in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.display(message);
      print("background but opend");
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: ControllerBinding(),
        title: 'India One',
        debugShowCheckedModeBanner: false,
        locale: Locale('en', 'US'),
        translations: LocaleString(),
        theme: ThemeData(
          fontFamily: AppFonts.appFont,
        ),
        onGenerateRoute: MRouter.generateRoute,
        initialRoute: MRouter.splashRoute);
  }
}

//fcm

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotification() {
  print("initializeNotification");
  setupFCMNotification();
  initializeLocalNotificationPlugin();
}

setupFCMNotification() async {
  if (Platform.isIOS) {
    await iOSPermission();
    await Future.delayed(Duration(milliseconds: 20));
  }
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print('Remote message: ${message.toString()}');
    }
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    print('A new onMessage.listen received!');
    if (notification != null && android != null) {
      showForegroundNotification(notification.title!, notification.body!);
    }
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AppleNotification? apple = message.notification?.apple;
    print('A new onMessage.listen received!');
    if (notification != null && apple != null) {
      showForegroundNotification(notification.title!, notification.body!);
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
  });
  await getPushToken();
  //notifyListeners();
}

Future iOSPermission() async {
  await _firebaseMessaging.requestPermission(
    sound: true,
    badge: false,
    alert: true,
  );
  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    sound: true,
    badge: false,
    alert: true,
  );
  // _firebaseMessaging.setForegroundNotificationPresentationOptions(
  // )
  _firebaseMessaging.onTokenRefresh.listen((settings) {
    print("Settings registered: $settings");
  });
}

Future getPushToken() async {
  await _firebaseMessaging.getToken().then((token) {
    print('FCM Token: $token');
    /*  if (token != null && !_fcmToken.isClosed) {
        //this.token = token;
        _fcmToken.sink.add(token);
      }*/
  });
}

Future initializeLocalNotificationPlugin() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  final InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future showForegroundNotification(String title, String body) async {
  // var android = AndroidNotificationDetails("id", "channel", "description");
  var android = AndroidNotificationDetails("id", "channel",
      channelDescription: "description",
      icon: "notificationimg",
      playSound: true,
      channelShowBadge: true,
      color: AppColors.primary);
  // var ios = IOSNotificationDetails();

  // var platform = new NotificationDetails(android: android, iOS: ios);
  var platform = new NotificationDetails(android: android);
  await _flutterLocalNotificationsPlugin.show(0, title, body, platform,
      payload: body);
}

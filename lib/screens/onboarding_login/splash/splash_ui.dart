import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import '../../home_start/home_main_io.dart';
import '../select_language/language_selection_io.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'ಕನ್ನಡ', 'locale': Locale('ka', 'IN')},
    {'name': 'मराठी', 'locale': Locale('ma', 'IN')},
    {'name': 'తెలుగు', 'locale': Locale('te', 'IN')},
    {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')},
    {'name': 'മലയാളം', 'locale': Locale('mal', 'IN')},
    {'name': 'বাংলো', 'locale': Locale('ban', 'IN')},
    {'name': 'ଓଡିଆ', 'locale': Locale('or', 'IN')},
  ];
  @override
  void initState() {
    super.initState();
     DioApiCall().refreshToken();

    FirebaseMessaging.instance.getToken().then((deviceToken) async {
      print("FCM / DEVICE TOKEN ${deviceToken}");
      String? deviceId = await _getDeviceId();
      print("device ID ${deviceId}");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs!.setString(SPKeys.DEVICE_ID, deviceId.toString());
      prefs!.setString(SPKeys.DEVICE_TOKEN, deviceToken.toString());
    });

    initDynamicLinks();

    Timer(Duration(seconds: 3), () => launchLoginWidget());
  }



  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      Get.toNamed(MRouter.splashRoute);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<String?> _getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  updateLanguage(Locale locale, int selectdLang) {
    Get.updateLocale(locale);
    setState(() {});
  }

  // launch login screen
  Future<void> launchLoginWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool(SPKeys.LOGGED_IN);


    if (loggedIn == true) {
    //

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs!.setBool(SPKeys.SHOW_AUTH, true);
        Get.offAllNamed(MRouter.homeScreen);
        int? selectedLan = prefs.getInt(SPKeys.SELECTED_LANGUAGE);
        updateLanguage(locale[selectedLan!.toInt()]['locale'], selectedLan);




    } else {
      Get.offAllNamed(MRouter.languageSelectionIO);
    }
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: buildSplashForMobile(),
        ),
      ),
    );
  }

  Widget buildSplashForMobile() {
    return Stack(
      children: [
        buildSplashBG(),
        buildSplashLogo(),
      ],
    );
  }

  Widget buildSplashLogo() {
    return Center(
      child: Hero(
        tag: 'logo_image',
        child: Image.asset(
          "assets/images/splash_logo.gif",
          width: 444,
          height: 654,
        ),
      ),
    );
  }

  Widget buildSplashBG() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.white,
    );
  }
}

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';
import '../../../core/data/local/shared_preference_keys.dart';
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
    FirebaseMessaging.instance.getToken().then((newToken){

      print("FCM TOKEN ${newToken}");


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

  updateLanguage(Locale locale, int selectdLang) {
    Get.updateLocale(locale);
    setState(() {
    });
  }

  // launch login screen
  Future<void> launchLoginWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool(SPKeys.LOGGED_IN);
    if(loggedIn == true )
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs!.setBool(SPKeys.SHOW_AUTH, true);
      Get.offAllNamed(MRouter.homeScreen);

      int? selectedLan = prefs.getInt(SPKeys.SELECTED_LANGUAGE);
      updateLanguage(locale[selectedLan!.toInt()]['locale'], selectedLan);


    }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LanguageSelectionIO('splash')));
    }
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        resizeToAvoidBottomInset: false, 
      body: buildSplashForMobile(),
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
        child:
        Image.asset(
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

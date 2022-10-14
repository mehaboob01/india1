import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import '../select_language/language_selection_io.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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
    // requestCameraPermission();

    Timer(Duration(seconds: 3), () => launchLoginWidget());
  }

  updateLanguage(Locale locale, int selectdLang) {
   // Get.back();
    Get.updateLocale(locale);
    // selectedLanguage = selectdLang;
    setState(() {
     // selectedLanguage;
    });
  }

  // launch login screen
  Future<void> launchLoginWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool(SPKeys.LOGGED_IN);



    if(loggedIn == true)
      {
        int selectedLan = prefs.getInt(SPKeys.SELECTED_LANGUAGE) as int;
        updateLanguage(locale[selectedLan]['locale'], selectedLan);
        Get.offAllNamed(MRouter.homeScreen);
      }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LanguageSelectionIO('splash')));
    }




    // Get.offAllNamed(MRouter.languageSelectionIO);

  }






  void getSignature() async {
    final String signature = await SmsAutoFill().getAppSignature;
    debugPrint('signature $signature');
  }
  // Future<void> initMobileNumberState() async {
  //
  //   try {
  //     var data = await autoFill.hint ?? '';
  //     if (data.isNotEmpty) {
  //       mobileNumber.value = data;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  //
  //   String val = mobileNumber.value.toString().replaceAll("+91", '');
  //   val = val.startsWith('0') ? val.replaceFirst('0', "") : val;
  //   validatePhone(val);
  //   phoneNumberController!.value.text = val;
  //
  // }
  // // validate phone
  // validatePhone(value) {
  //   String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
  //   RegExp regExp = RegExp(pattern);
  //   if (value.isEmpty) {
  //     validateMobile.value = false;
  //   } else if (!regExp.hasMatch(value)) {
  //     validateMobile.value = false;
  //   } else {
  //     String val =
  //     phoneNumberController!.value.text.toString().replaceAll("+91", '');
  //     val = val.startsWith('0') ? val.replaceFirst('0', "") : val;
  //     phoneNumberController!.value.text = val;
  //     validateMobile.value = true;
  //     // phoneNumberController!.value.selection = TextSelection.fromPosition(
  //     //     TextPosition(offset: phoneNumberController!.value.text.length));
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
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
          "assets/images/splash_logo.png",
          width: 288,
          height: 240,
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

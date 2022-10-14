import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';
import '../../../core/data/local/shared_preference_keys.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // requestCameraPermission();

    Timer(Duration(seconds: 3), () => launchLoginWidget());
  }

  // launch login screen
  Future<void> launchLoginWidget() async {
    Get.offAllNamed(MRouter.languageSelectionIO);
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

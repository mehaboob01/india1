

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';

class VerifiedScreen extends StatefulWidget {
  VerifiedScreen({Key? key}) : super(key: key);

  @override
  State<VerifiedScreen> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  @override
  void initState() {
    super.initState();
    // requestCameraPermission();

    Timer(Duration(seconds: 2), () => launchLoginWidget());
  }

  // launch login screen
  Future<void> launchLoginWidget() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // //Return String
    // String? stringValue = prefs.getString('CurrentUser');
    // print("Current User");
    // print(stringValue);

     Get.offAllNamed(MRouter.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/complete.gif",
            width: 284,
            height: 284,
          ),
        ),
        Text(
          "OTP VERIFIED SUCCESSFULLY!",
          overflow: TextOverflow.visible,
          maxLines: 1,
          style: TextStyle(
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.w800,
            color: AppColors.btnColor,
            fontSize: Dimens.font_18sp,
          ),
        ),
      ],
    );
  }

  Widget buildSplashBG() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.white,
    );
  }

// Future<void> requestCameraPermission() async {
//   final serviceStatus = await Permission.camera.isGranted;
//
//   bool isCameraOn = serviceStatus == ServiceStatus.enabled;
//
//   final status = await Permission.camera.request();
//
//   if (status == PermissionStatus.granted) {
//     print('Permission Granted');
//   } else if (status == PermissionStatus.denied) {
//     print('Permission denied');
//   } else if (status == PermissionStatus.permanentlyDenied) {
//     print('Permission Permanently Denied');
//     await openAppSettings();
//   }
// }
}
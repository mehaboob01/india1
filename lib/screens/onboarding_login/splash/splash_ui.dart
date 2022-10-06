import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';

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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // //Return String
    // String? stringValue = prefs.getString('CurrentUser');
    // print("Current User");
    // print(stringValue);

    Get.offAllNamed(MRouter.languageSelectionIO);
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
    return Center(
      child: Hero(
        tag: 'logo_image',
        child:
        Image.asset(
          "assets/images/india_one_logo.png",
          width: 244,
          height: 184,
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';

class VerifiedScreen extends StatefulWidget {
  @override
  State<VerifiedScreen> createState() => _VerifiedScreenState();
}

class _VerifiedScreenState extends State<VerifiedScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushNamedAndRemoveUntil(
            MRouter.homeScreen, (Route<dynamic> route) => false));
  }

  Future<void> launchLoginWidget() async {
    Get.offAllNamed(MRouter.mobileRechargeIO);
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  @override
  Widget build(BuildContext context) {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/success.gif",
            width: 320,
            height: 320,
          ),
        ),
        text(
          "Successful!",
          textOverflow: TextOverflow.visible,
          maxLines: 1,
          style: TextStyle(
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
            fontSize: Dimens.font_24sp,
          ),
        ),
        SizedBox(
          height: 44,
        ),
        // text(
        //   "Mobile Recharge successful!",
        //   overflow: TextOverflow.visible,
        //   maxLines: 1,
        //   style: TextStyle(
        //     overflow: TextOverflow.visible,
        //     fontWeight: FontWeight.w500,
        //     color: AppColors.primary,
        //     fontSize: Dimens.font_18sp,
        //   ),
        // ),
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
}

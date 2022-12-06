import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/refer/contacts_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/theme_manager.dart';
import '../core/data/local/shared_preference_keys.dart';
import '../screens/refer/refer_earn_ui.dart';

class CommonBanner extends StatelessWidget {
  final bool? isTapable;
  final EdgeInsetsGeometry? margin;

  ContactCont _cont = Get.put(ContactCont());
  Future _handleLocationPermission() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? firstInit =
    sharedPreferences.getBool(SPKeys.FIRST_INIT_CONTACT_PERMISSION);
    var status = Permission.contacts.request();
    if (await status.isGranted || await status.isLimited) {
      _cont.isPermissionAllowed.value = true;
      Get.to(ReferEarn());
    } else if (await status.isDenied) {
      _cont.isPermissionAllowed.value = false;
      Get.to(ReferEarn());
      if (firstInit != null) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_CONTACT_PERMISSION, true);
      }
    } else if (await status.isPermanentlyDenied) {
      if (firstInit == null || firstInit) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_CONTACT_PERMISSION, false);
        return false;
      } else {
        _cont.isPermissionAllowed.value = false;
        Get.to(ReferEarn());
      }

    }
  }

  CommonBanner({super.key, this.isTapable = true, this.margin});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isTapable == true
          ? () async {
              await _handleLocationPermission();
            }
          : null,
      child: Container(
        width: double.maxFinite,
        height: 32.0.wp,
        margin: margin ?? EdgeInsets.symmetric(horizontal: 4.0.wp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0.wp),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.referEarnGradient1,
                  AppColors.referEarnGradient2
                ])),
        // image: const DecorationImage(
        //     image: AssetImage(AppImages.atmBg2), fit: BoxFit.fill)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // text
            Flexible(
              flex: 4,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 6.0.wp, bottom: 6.0.wp, left: 4.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: AppStyle.shortHeading.copyWith(
                                color: Colors.white,
                                //fontWeight: FontWeight.w600,
                                fontSize: 8.0.sp,
                                height: 1.5),
                            text:
                                'Refer a friend or a family member & get\na chance to',
                            children: [
                          TextSpan(
                              text: ' Earn upto 100 points',
                              style: AppStyle.shortHeading.copyWith(
                                  color: Colors.white,
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w600)),
                        ])),
                    // SizedBox(height: 1.0.wp),
                    isTapable == true
                        ? SizedBox(height: 5.0.wp)
                        : SizedBox.shrink(),
                    isTapable == true
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Refer Now',
                                  style: AppStyle.shortHeading.copyWith(
                                      color: AppColors.yellowgradient1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.0.sp)),
                              SizedBox(width: 2.0.wp),
                              Image.asset(AppImages.rightArrow)
                            ],
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ),
            ),
            // Right Image
            Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 2.0.wp, bottom: 2.0.wp, left: 2.0.wp, right: 2.0.wp),
                  //color: Colors.red,
                  child: Center(
                      child: Image.asset(
                    AppImages.referEarnSVG,
                    fit: BoxFit.fill,
                  )),
                ))
          ],
        ),
      ),
    );
  }
}

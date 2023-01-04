import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:india_one/screens/home_start/home_manager.dart';
import 'package:india_one/screens/insurances/model/insurance_summary_model.dart';
import 'package:india_one/screens/profile/profile_screen.dart';
import 'package:india_one/widgets/button_with_flower.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'constant/theme_manager.dart';

class DisplayPopuP {
  Future welcomepopup(
      {required BuildContext context, required String welcomePoints}) async {
    return Future.delayed(
        Duration(milliseconds: 300),
        () => Alert(
              padding: EdgeInsets.zero,
              style: AlertStyle(
                  alertPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alertBorder: Border.all(width: 0)),
              buttons: [],
              context: context,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.Welcome_home_popbg))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to',
                        style: AppStyle.shortHeading
                            .copyWith(height: 1.2, fontSize: Dimens.font_24sp),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cashback',
                            style: AppStyle.shortHeading.copyWith(
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                letterSpacing: 1.2,
                                fontSize: Dimens.font_24sp),
                          ),
                          Text(
                            ' by ',
                            style: AppStyle.shortHeading.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                fontSize: Dimens.font_20sp),
                          ),
                          Text(
                            'India1',
                            style: AppStyle.shortHeading.copyWith(
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                letterSpacing: 1.2,
                                fontSize: Dimens.font_24sp),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        'You just won',
                        style: AppStyle.shortHeading
                            .copyWith(fontSize: Dimens.font_20sp),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimens.padding_12dp),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(AppImages.goldenHexagonal),
                            Positioned(
                              top: 45,
                              child: Text(
                                welcomePoints,
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Points',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: Dimens.font_24sp),
                      ),
                    ],
                  ),
                ),
              ),
            ).show());

  }

  Future getProfileWelcome(
      {required BuildContext context, required String profilePoints}) {
    double height = Get.height;
    double width = Get.width;
    return Future.delayed(
        Duration(milliseconds: 300),
        () => Alert(
              padding: EdgeInsets.zero,
              style: AlertStyle(
                  alertPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alertBorder: Border.all(width: 0)),
              buttons: [],
              context: context,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   'Complete your profile',
                      //   style: AppStyle.shortHeading.copyWith(
                      //       height: 1.2,
                      //       color: AppColors.orangeColor,
                      //       fontSize: Dimens.font_24sp),
                      // ),
                      Text(
                        'Complete your profile',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                            color: AppColors.orangeColor,
                            letterSpacing: 1.2,
                            fontSize: Dimens.font_20sp),
                      ),

                      SizedBox(height: height * 0.02),
                      Text(
                        'You have a chance to',
                        style: AppStyle.shortHeading.copyWith(
                            fontSize: Dimens.font_18sp, color: Colors.black),
                      ),
                      Text(
                        'earn upto',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: Dimens.font_18sp),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimens.padding_12dp),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(AppImages.goldenHexagonal),
                            Positioned(
                              top: 45,
                              child: Text(
                                profilePoints,
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Points',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: Dimens.font_20sp),
                      ),
                      SizedBox(height: height * 0.05),
                      ButtonWithFlower(
                          label: 'OK',
                          onPressed: () => Get.to(ProfileScreen()),
                          buttonWidth: width * 0.4,
                          buttonHeight: 40,
                          labelSize: 18,
                          buttonGradient: const LinearGradient(
                              begin: Alignment(-2, 0),
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.orangeGradient1,
                                AppColors.orangeGradient2,
                              ]),
                          iconToRight: false,
                          labelColor: Colors.white,
                          labelWeight: FontWeight.normal)
                    ],
                  ),
                ),
              ),
            ).show());
  }

  // (value) => prefs!.setInt(SPKeys.LOYALTY_POINT_GAINED, 0));

}

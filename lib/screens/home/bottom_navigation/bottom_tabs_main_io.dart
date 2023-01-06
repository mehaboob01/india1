import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/Pages/loans.dart';
import 'package:india_one/screens/Pages/payments.dart';

import 'package:india_one/screens/home/bottom_navigation/custom_widgets/home_each_bottom_tab_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import '../../Pages/insurance.dart';
import '../../Pages/savings.dart';
import '../../home_start/home_main_io.dart';
import 'package:onboarding_overlay/onboarding_overlay.dart';

class BottomTabsMainIO extends StatefulWidget {
  const BottomTabsMainIO({Key? key}) : super(key: key);

  @override
  State<BottomTabsMainIO> createState() => _BottomTabsMainIOState();
}

class _BottomTabsMainIOState extends State<BottomTabsMainIO> {
  double heightIs = 0, widthIs = 0;
  int selectedTabId = 0;
  Widget mainHomeWidget = Container();
  final GlobalKey<OnboardingState> onboardingKey = GlobalKey<OnboardingState>();

  final List<FocusNode> _focusNodes = <FocusNode>[
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    mainHomeWidget = HomeMainIO(false, _focusNodes);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        Duration(milliseconds: 3000),
        () async {
          var prefs = await SharedPreferences.getInstance();
          bool isFirstTime = prefs.getBool("isFirstTime") ?? true;
          if (isFirstTime) {
            onboardingKey.currentState!.show();
            prefs.setBool("isFirstTime", false);
          }
        },
      );
    });
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    final List<OnboardingStep> steps = [
      OnboardingStep(
          focusNode: _focusNodes[0],
          bodyText:
              "Check out all services, find nearest ATM, Redeem your points",
          hasLabelBox: false,
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.9),
          hasArrow: false,
          titleText: "ACCESS ALL FEATURES",
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onboardingKey.currentState!.hide();
                      },
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(AppImages.skipWalkThroughSvg)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        AppImages.arrowDownLeftSvg,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              renderInfo.titleText.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              // style: renderInfo.titleStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              renderInfo.bodyText,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                renderInfo.nextStep();
                              },
                              child: Container(
                                // width: MediaQuery.of(context).size.height * 0.8,
                                width: 80,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'NEXT',
                                      style: AppTextThemes.labelStyle.apply(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    end: Alignment.topRight,
                                    colors: [
                                      AppColors.yellowgradient1,
                                      AppColors.yellowgradient2,
                                      AppColors.yellowgradient2,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      OnboardingStep(
          focusNode: _focusNodes[1],
          titleTextStyle: Theme.of(context).textTheme.headline5,
          bodyText: "Compare and choose the best provider and apply for loan",
          hasLabelBox: false,
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.9),
          hasArrow: false,
          titleText: "APPLY FOR LOAN",
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onboardingKey.currentState!.hide();
                      },
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(AppImages.skipWalkThroughSvg)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      SvgPicture.asset(
                        AppImages.arrowDownLeft2Svg,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              renderInfo.titleText.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              // style: renderInfo.titleStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              renderInfo.bodyText,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                renderInfo.nextStep();
                              },
                              child: Container(
                                // width: MediaQuery.of(context).size.height * 0.8,
                                width: 80,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'NEXT',
                                      style: AppTextThemes.labelStyle.apply(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    end: Alignment.topRight,
                                    colors: [
                                      AppColors.yellowgradient1,
                                      AppColors.yellowgradient2,
                                      AppColors.yellowgradient2,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      OnboardingStep(
          focusNode: _focusNodes[2],
          titleTextStyle: Theme.of(context).textTheme.headline5,
          bodyText: "Recharge mobile, DTH, FASTag / Other bill payments",
          bodyTextStyle: Theme.of(context).textTheme.subtitle1,
          hasLabelBox: false,
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.9),
          hasArrow: false,
          titleText: "Recharge / Bill Payment",
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onboardingKey.currentState!.hide();
                      },
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(AppImages.skipWalkThroughSvg)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              renderInfo.titleText.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              // style: renderInfo.titleStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              renderInfo.bodyText,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    renderInfo.nextStep();
                                  },
                                  child: Container(
                                    // width: MediaQuery.of(context).size.height * 0.8,
                                    width: 80,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'NEXT',
                                          style: AppTextThemes.labelStyle.apply(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                        end: Alignment.topRight,
                                        colors: [
                                          AppColors.yellowgradient1,
                                          AppColors.yellowgradient2,
                                          AppColors.yellowgradient2,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                SvgPicture.asset(
                                  AppImages.arrowDownRightSvg,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      OnboardingStep(
          focusNode: _focusNodes[3],
          titleTextStyle: Theme.of(context).textTheme.headline5,
          bodyText: "Choose the best health insurance, vehicle insurance",
          bodyTextStyle: Theme.of(context).textTheme.subtitle1,
          hasLabelBox: false,
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.9),
          hasArrow: false,
          titleText: "INSURANCE",
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onboardingKey.currentState!.hide();
                      },
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(AppImages.skipWalkThroughSvg)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: widthIs * 0.2,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              renderInfo.titleText.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              // style: renderInfo.titleStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              renderInfo.bodyText,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    renderInfo.nextStep();
                                  },
                                  child: Container(
                                    // width: MediaQuery.of(context).size.height * 0.8,
                                    width: 80,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'NEXT',
                                          style: AppTextThemes.labelStyle.apply(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                        end: Alignment.topRight,
                                        colors: [
                                          AppColors.yellowgradient1,
                                          AppColors.yellowgradient2,
                                          AppColors.yellowgradient2,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                SvgPicture.asset(
                                  AppImages.arrowDownRightSvg,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      OnboardingStep(
          focusNode: _focusNodes[4],
          bodyText: "Compare and choose the best vendors for your investment",
          hasLabelBox: false,
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.9),
          hasArrow: false,
          titleText: "SAVINGS",
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onboardingKey.currentState!.hide();
                      },
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(AppImages.skipWalkThroughSvg)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: widthIs * 0.4,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              renderInfo.titleText.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              // style: renderInfo.titleStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              renderInfo.bodyText,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    renderInfo.nextStep();
                                  },
                                  child: Container(
                                    // width: MediaQuery.of(context).size.height * 0.8,
                                    width: 80,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'NEXT',
                                          style: AppTextThemes.labelStyle.apply(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                        end: Alignment.topRight,
                                        colors: [
                                          AppColors.yellowgradient1,
                                          AppColors.yellowgradient2,
                                          AppColors.yellowgradient2,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                SvgPicture.asset(
                                  AppImages.arrowDownRightSvg,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      // OnboardingStep(
      //     focusNode: _focusNodes[5],
      //     bodyText: "Choose the language that you are comfortable with",
      //     hasLabelBox: false,
      //     fullscreen: true,
      //     overlayColor: Colors.black.withOpacity(0.9),
      //     hasArrow: false,
      //     titleText: "CHANGE LANGUAGE",
      //     stepBuilder: (
      //       BuildContext context,
      //       OnboardingStepRenderInfo renderInfo,
      //     ) {
      //       return Material(
      //         color: Colors.transparent,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Row(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Expanded(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         renderInfo.titleText.toUpperCase(),
      //                         style: TextStyle(
      //                           color: Colors.white,
      //                           fontFamily: AppFonts.appFont,
      //                           fontWeight: FontWeight.w500,
      //                           fontSize: 18,
      //                         ),
      //                         // style: renderInfo.titleStyle,
      //                       ),
      //                       const SizedBox(
      //                         height: 30,
      //                       ),
      //                       Text(
      //                         renderInfo.bodyText,
      //                         style: TextStyle(
      //                           color: Colors.white,
      //                           fontFamily: AppFonts.appFont,
      //                           fontWeight: FontWeight.w400,
      //                           fontSize: 16,
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         height: 30,
      //                       ),
      //                       InkWell(
      //                         onTap: () {
      //                           renderInfo.nextStep();
      //                         },
      //                         child: Container(
      //                           // width: MediaQuery.of(context).size.height * 0.8,
      //                           width: 80,
      //                           height: 40,
      //                           child: Row(
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               Text(
      //                                 'NEXT',
      //                                 style: AppTextThemes.labelStyle.apply(
      //                                   color: Colors.black,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                           decoration: BoxDecoration(
      //                             gradient: new LinearGradient(
      //                               end: Alignment.topRight,
      //                               colors: [
      //                                 AppColors.yellowgradient1,
      //                                 AppColors.yellowgradient2,
      //                                 AppColors.yellowgradient2,
      //                               ],
      //                             ),
      //                             borderRadius: BorderRadius.circular(6.0),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   width: 40,
      //                 ),
      //                 SvgPicture.asset(
      //                   AppImages.arrowUpRightSvg,
      //                 ),
      //                 SizedBox(
      //                   width: widthIs * 0.2,
      //                 ),
      //               ],
      //             ),
      //             Align(
      //               alignment: Alignment.centerRight,
      //               child: GestureDetector(
      //                 behavior: HitTestBehavior.translucent,
      //                 onTap: () {
      //                   onboardingKey.currentState!.hide();
      //                 },
      //                 child: SizedBox(
      //                   width: 80,
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         "Skip",
      //                         style: TextStyle(
      //                           color: Colors.white,
      //                           fontFamily: AppFonts.appFont,
      //                           fontWeight: FontWeight.w600,
      //                           fontSize: 18,
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         width: 6,
      //                       ),
      //                       SvgPicture.asset(AppImages.skipWalkThroughSvg)
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     }),
      OnboardingStep(
          focusNode: _focusNodes[5],
          bodyText: "Access to all your app related notifications",
          hasLabelBox: false,
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.9),
          hasArrow: false,
          titleText: "NOTIFICATIONS",
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widthIs * 0.1,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              renderInfo.titleText.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              // style: renderInfo.titleStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              renderInfo.bodyText,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                renderInfo.nextStep();
                              },
                              child: Container(
                                // width: MediaQuery.of(context).size.height * 0.8,
                                width: 80,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'NEXT',
                                      style: AppTextThemes.labelStyle.apply(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    end: Alignment.topRight,
                                    colors: [
                                      AppColors.yellowgradient1,
                                      AppColors.yellowgradient2,
                                      AppColors.yellowgradient2,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      SvgPicture.asset(
                        AppImages.arrowUpRightSvg,
                      ),
                      SizedBox(
                        width: widthIs * 0.1,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onboardingKey.currentState!.hide();
                      },
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(AppImages.skipWalkThroughSvg)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      OnboardingStep(
          focusNode: _focusNodes[6],
          bodyText: "View and manage your profile details here",
          hasLabelBox: false,
          fullscreen: true,
          overlayColor: Colors.black.withOpacity(0.9),
          hasArrow: false,
          titleText: "PROFILE",
          stepBuilder: (
            BuildContext context,
            OnboardingStepRenderInfo renderInfo,
          ) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widthIs * 0.2,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              renderInfo.titleText.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              // style: renderInfo.titleStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              renderInfo.bodyText,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                renderInfo.nextStep();
                              },
                              child: Container(
                                // width: MediaQuery.of(context).size.height * 0.8,
                                width: 80,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'NEXT',
                                      style: AppTextThemes.labelStyle.apply(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  gradient: new LinearGradient(
                                    end: Alignment.topRight,
                                    colors: [
                                      AppColors.yellowgradient1,
                                      AppColors.yellowgradient2,
                                      AppColors.yellowgradient2,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      SvgPicture.asset(
                        AppImages.arrowUpRightSvg,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onboardingKey.currentState!.hide();
                      },
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(AppImages.skipWalkThroughSvg)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    ];

    return Onboarding(
      key: onboardingKey,
      steps: steps,
      onChanged: (int index) {
        debugPrint('----index $index');
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            SizedBox(
              height: heightIs - bottomMargin + 9,
              child: mainHomeWidget,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AppColors.transparent,
                height: bottomNavigationCircleRadius,
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Focus(
                          focusNode: _focusNodes[0],
                          child: HomeEachBottomTabIO(
                              'assets/images/homeInactive.svg',
                              'assets/images/underline.svg',
                              "${'home'.tr}", () {
                            selectedTabId = 0;
                            mainHomeWidget = HomeMainIO(false, _focusNodes);
                            setState(() {
                              showAuth();
                              selectedTabId;
                              mainHomeWidget;
                            });
                          }, selectedTabId == 0, 12),
                        ),
                        Focus(
                          focusNode: _focusNodes[1],
                          child: HomeEachBottomTabIO(
                              'assets/images/loanInactive.svg',
                              'assets/images/underline.svg',
                              "${'loans'.tr}", () {
                            selectedTabId = 1;
                            mainHomeWidget = LoansPage();
                            setState(() {
                              showAuth();
                              selectedTabId;
                              mainHomeWidget;
                            });
                          }, selectedTabId == 1, 12),
                        ),
                        Focus(
                          focusNode: _focusNodes[2],
                          child: HomeEachBottomTabIO(
                              'assets/images/paymentsInactive.svg',
                              'assets/images/underline.svg',
                              "${'payments'.tr}", () {
                            selectedTabId = 2;
                            mainHomeWidget = PaymentsPage();
                            setState(() {
                              showAuth();
                              selectedTabId;
                              mainHomeWidget;
                            });
                          }, selectedTabId == 2, 12),
                        ),
                        Focus(
                          focusNode: _focusNodes[3],
                          child: HomeEachBottomTabIO(
                              'assets/images/insuranceInactive.svg',
                              'assets/images/underline.svg',
                              "${'insurance'.tr}", () {
                            selectedTabId = 3;
                            mainHomeWidget = InsurancePage();
                            setState(() {
                              showAuth();
                              selectedTabId;
                              mainHomeWidget;
                            });
                          }, selectedTabId == 3, 12),
                        ),
                        Focus(
                          focusNode: _focusNodes[4],
                          child: HomeEachBottomTabIO(
                              'assets/images/savingsInactive.svg',
                              'assets/images/underline.svg',
                              "${'savings'.tr}", () {
                            selectedTabId = 4;
                            mainHomeWidget = SavingsPage();
                            setState(() {
                              showAuth();
                              selectedTabId;
                              mainHomeWidget;
                            });
                          }, selectedTabId == 4, 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs!.setBool(SPKeys.SHOW_AUTH, false);
  }
}

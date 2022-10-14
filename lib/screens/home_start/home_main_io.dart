import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/theme_manager.dart';
import '../../core/data/local/shared_preference_keys.dart';
import '../../widgets/carasoul_slider.dart';

import '../Pages/insurance.dart';
import '../Pages/loans.dart';
import '../Pages/payments.dart';
import '../Pages/savings.dart';
import '../onboarding_login/select_language/language_selection_io.dart';
import 'home_manager.dart';

class HomeMainIO extends StatefulWidget {
  const HomeMainIO({Key? key}) : super(key: key);

  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> {
  void showFirstTimePoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTimeLogin = prefs.getBool(SPKeys.FIRST_TIME_LOGIN_POINTS);
    if (firstTimeLogin == true) {
    } else {
      SharedPreferences.getInstance().then((value) {
        value.setBool(SPKeys.FIRST_TIME_LOGIN_POINTS, true);
      }).then((value) => Future.delayed(
          Duration.zero,
          () => Alert(
                buttons: [],
                context: context,
                title: "Welcome to India1 Cashback Program",
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 4,
                    ),
                    Image.asset(
                      "assets/images/rewards.gif",
                      width: 224,
                      height: 184,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "You just won",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.black,
                        fontSize: Dimens.font_12sp,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "10 points",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: Dimens.font_18sp,
                      ),
                    ),
                  ],
                ),
              ).show()));
    }
  }

  @override
  void initState() {

    super.initState();
    _homeManager.callHomeApi(context);
    showFirstTimePoints();
  }

  HomeManager _homeManager = Get.put(HomeManager());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(


      onWillPop: () async {
        Get.defaultDialog(
          cancelTextColor: AppColors.white,
          title: "Exit",
          middleText: "Do you  want to close the app?",
          confirm: confirmBtn(),
          cancel: cancelBtn(),
          radius: 8,
          backgroundColor: AppColors.cardBg1,
          titleStyle:
          TextStyle(color: Colors.white, fontSize: Dimens.font_14sp),
          middleTextStyle:
          TextStyle(color: Colors.white, fontSize: Dimens.font_12sp),
        );
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // top container ---------------------
              Container(
                padding: EdgeInsets.fromLTRB(4.0.wp, 20.0.wp, 4.0.wp, 4.0.wp),
                height: 50.0.hp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.0.wp),
                      bottomRight: Radius.circular(5.0.wp)),
                  image: DecorationImage(
                      image: AssetImage(AppImages.homebg), fit: BoxFit.fill),

                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('welcome'.tr,
                                style: AppStyle.shortHeading.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              headingBox(
                                  text: 'Aa',
                                  ontap: () {
                                    // Get.toNamed(
                                    //     MRouter.languageSelectionIO);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LanguageSelectionIO('home')));
                                  }),
                              SizedBox(
                                width: 2.0.wp,
                              ),
                              headingBox(imagePath: AppImages.notify_icon),
                              SizedBox(width: 2.0.wp),
                              headingBox(imagePath: AppImages.user_profile)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0.hp),
                      Text('cashback_india1_summary'.tr,
                          style: AppStyle.shortHeading.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2.0.hp),
                      // balance card --------------------------
                      Row(
                        children: [
                          Expanded(child: balanceCard(first: true)),
                          SizedBox(width: 2.0.wp),
                          Expanded(child: balanceCard(first: false))
                        ],
                      ),
                      // ways to Reedem ---------------------------------
                      SizedBox(height: 2.0.hp),
                      Flexible(child: redeemWay()),
                      // Redeem points now -------------------------------
                      SizedBox(height: 2.0.hp),
                      Flexible(child: redeemPoints()),
                    ]),
              ),

              // nearest atm ---------------------
              nearestAtm(),
              // carosuel Images --------------------
              CarasoulImages(),
              Padding(
                padding: EdgeInsets.only(
                    left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Loans',
                  style: AppStyle.shortHeading.copyWith(
                      fontSize: 16.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: LoansPage(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Payments',
                  style: AppStyle.shortHeading.copyWith(
                      fontSize: 16.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: PaymentsPage(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Insurance',
                  style: AppStyle.shortHeading.copyWith(
                      fontSize: 16.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: InsurancePage(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Savings',
                  style: AppStyle.shortHeading.copyWith(
                      fontSize: 16.0.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: SavingsPage(),
              )
            ],
          ),
        ),
      ),
    );
  }

// heading box -----------------------------------
  Widget headingBox(
      {IconData? icon, String? text, VoidCallback? ontap, String? imagePath}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: text != null
            ? Center(
                child: Text(
                text!,
                style: TextStyle(fontWeight: FontWeight.normal),
              ))
            : imagePath != null
                ? Center(child: SvgPicture.asset(imagePath))
                : Icon(icon),
      ),
    );
  }

  // balance card ----------------------------------------------
  Widget balanceCard({required bool first}) {
    return Container(
        padding: EdgeInsets.all(2.0.wp),
        height: 10.0.hp,
        decoration: BoxDecoration(
          color: AppColors.backGrounddarkheader,
          borderRadius: first
              ? BorderRadius.only(
                  topLeft: Radius.circular(2.0.wp),
                  topRight: Radius.circular(12.0.wp),
                  bottomLeft: Radius.circular(2.0.wp),
                  bottomRight: Radius.circular(2.0.wp))
              : BorderRadius.only(
                  topLeft: Radius.circular(12.0.wp),
                  topRight: Radius.circular(2.0.wp),
                  bottomLeft: Radius.circular(2.0.wp),
                  bottomRight: Radius.circular(2.0.wp)),
        ),
        child: first
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current balance',
                    style: AppStyle.shortHeading.copyWith(
                        fontSize: 12.0.sp,
                        color: Colors.white,
                        letterSpacing: 0.5),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Image.asset(AppImages.coins),
                      ),
                      Obx(
                        () => Text(
                          _homeManager.redeemablePoints.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        ' Points',
                        style: AppStyle.shortHeading.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total earned : ',
                        style: AppStyle.shortHeading.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                      Obx(
                        () => Text(
                          _homeManager.pointsEarned.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total redeemed : ',
                        style: AppStyle.shortHeading.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                      Obx(
                        () => Text(
                          _homeManager.pointsEarned.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }

  // ways to redeem -------------------------------------------------
  Widget redeemWay() {
    return Container(
      padding: EdgeInsets.all(2.0.wp),
      height: 8.0.hp,
      decoration: BoxDecoration(
          color: AppColors.backGrounddarkheader,
          borderRadius: BorderRadius.circular(2.0.wp)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ways to redeem :',
            style: AppStyle.shortHeading.copyWith(
                fontSize: 10.0.sp, color: Colors.white, letterSpacing: 0.5),
          ),
          redeemWaySub(image: AppImages.recharge, text: 'Recharge'),
          redeemWaySub(image: AppImages.cashback, text: 'Cashback')
        ],
      ),
    );
  }

  Widget redeemWaySub({required String image, required String text}) {
    return Row(
      children: [
        SvgPicture.asset(image),
        SizedBox(width: 1.0.wp),
        Text(
          text,
          style: AppStyle.shortHeading.copyWith(
              fontSize: 10.0.sp,
              color: AppColors.textColorshade,
              letterSpacing: 0.5),
        ),
      ],
    );
  }
  // redeem points container ------------------------

  Widget redeemPoints({VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 8.0.hp,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(2.0.wp)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'redeem_points_now'.tr,
                style: AppStyle.shortHeading.copyWith(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.butngradient1,
                    letterSpacing: 0.5),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  AppImages.bgflower,
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ),
    );
  }

// find nearest Atm -------------------------------
  Widget nearestAtm({VoidCallback? onPressed}) {
    return Container(
      height: 20.0.wp,
      margin: EdgeInsets.all(2.0.hp),
      padding: EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0.wp),
          image: const DecorationImage(
              image: AssetImage(AppImages.nearestAtmBg), fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find the nearest India1 ATM',
            style: AppStyle.shortHeading.copyWith(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5),
          ),
          SizedBox(height: 1.0.hp),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '2x/3x',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                ' rewards at ATMs',
                style: AppStyle.shortHeading
                    .copyWith(fontSize: 15, color: Colors.black),
              ),
              SizedBox(width: 6.0.wp),
              Flexible(
                child: GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    height: 4.0.hp,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.yellowgradient1,
                              AppColors.yellowgradient2
                            ]),
                        borderRadius: BorderRadius.circular(2.0.wp)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Locate ATM',
                            style: AppStyle.shortHeading.copyWith(
                                fontSize: 10.0.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.butngradient1,
                                letterSpacing: 0.5),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: 0.3,
                              child: Image.asset(
                                AppImages.bgflower,
                                fit: BoxFit.fill,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Get it on India1 -------------------------------
  Widget india1Carasoul({VoidCallback? onPressed}) {
    return Container(
      height: 20.0.wp,
      margin: EdgeInsets.all(2.0.hp),
      padding: EdgeInsets.symmetric(horizontal: 2.0.hp, vertical: 1.0.hp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0.wp),
          image: const DecorationImage(
              image: AssetImage(AppImages.atmBg2), fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find the nearest India1 ATM',
            style: AppStyle.shortHeading.copyWith(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5),
          ),
          SizedBox(height: 1.0.hp),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '2x/3x',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                ' rewards at ATMs',
                style: AppStyle.shortHeading
                    .copyWith(fontSize: 15, color: Colors.black),
              ),
              SizedBox(width: 2.0.wp),
              Flexible(
                child: GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    height: 4.0.hp,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.yellowgradient1,
                              AppColors.yellowgradient2
                            ]),
                        borderRadius: BorderRadius.circular(2.0.wp)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Locate ATM',
                            style: AppStyle.shortHeading.copyWith(
                                fontSize: 10.0.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.butngradient1,
                                letterSpacing: 0.5),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: 0.3,
                              child: Image.asset(
                                AppImages.bgflower,
                                fit: BoxFit.fill,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget confirmBtn() {
    return ElevatedButton(

        onPressed: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
        child: Text("Yes"));
  }



  Widget cancelBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text("No"));
  }

}

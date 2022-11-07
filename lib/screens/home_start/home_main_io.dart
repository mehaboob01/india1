import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/carasoul_slider.dart';
import '../Pages/insurance.dart';
import '../Pages/loans.dart';
import '../Pages/payments.dart';
import '../Pages/savings.dart';
import '../onboarding_login/otp_screen/otp_manager.dart';
import '../onboarding_login/select_language/language_selection_io.dart';
import '../profile/profile_screen.dart';
import 'home_manager.dart';

class HomeMainIO extends StatefulWidget {
  const HomeMainIO({Key? key}) : super(key: key);

  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> {
  OtpManager _otpManager = Get.put(OtpManager());

  void showFirstTimePoints() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? firstTimeLogin = prefs.getBool(SPKeys.FIRST_TIME_LOGIN_POINTS);

    if (_homeManager.loyalityPoints.toString() == "0") {
    } else {
      Future.delayed(
          Duration(milliseconds: 300),
          () => Alert(
                buttons: [],
                context: context,
                title: "Welcome to India1 Cashback Program",
                content: Obx(
                  () => Column(
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
                        _homeManager.loyalityPoints.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: Dimens.font_18sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ).show());
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
          titleStyle: TextStyle(color: Colors.white, fontSize: Dimens.font_14sp),
          middleTextStyle: TextStyle(color: Colors.white, fontSize: Dimens.font_12sp),
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
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.0.wp), bottomRight: Radius.circular(5.0.wp)),
                  image: DecorationImage(image: AssetImage(AppImages.homebg), fit: BoxFit.fill),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('welcome'.tr, style: AppStyle.shortHeading.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
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

                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LanguageSelectionIO('home')));
                              }),
                          SizedBox(
                            width: 2.0.wp,
                          ),
                          headingBox(imagePath: AppImages.notify_icon),
                          SizedBox(width: 2.0.wp),
                          InkWell(
                            onTap: () {
                              Get.to(() => ProfileScreen());
                            },
                            child: headingBox(imagePath: AppImages.user_profile),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.0.hp),
                  Text('cashback_india1_summary'.tr, style: AppStyle.shortHeading.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2.0.hp),
                  // balance card --------------------------
                  Row(
                    children: [Expanded(child: balanceCard(first: true)), SizedBox(width: 2.0.wp), Expanded(child: balanceCard(first: false))],
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
                padding: EdgeInsets.only(left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Loans',
                  style: AppStyle.shortHeading.copyWith(fontSize: 16.0.sp, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: LoansPage(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Payments',
                  style: AppStyle.shortHeading.copyWith(fontSize: 16.0.sp, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: PaymentsPage(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Insurance',
                  style: AppStyle.shortHeading.copyWith(fontSize: 16.0.sp, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                child: InsurancePage(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0.wp, top: 12.0.wp, bottom: 2.0.wp, right: 6.0.wp),
                child: Text(
                  'Savings',
                  style: AppStyle.shortHeading.copyWith(fontSize: 16.0.sp, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1),
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
  Widget headingBox({IconData? icon, String? text, VoidCallback? ontap, String? imagePath}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: text != null
            ? Center(
                child: Text(
                text,
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
              ? BorderRadius.only(topLeft: Radius.circular(2.0.wp), topRight: Radius.circular(12.0.wp), bottomLeft: Radius.circular(2.0.wp), bottomRight: Radius.circular(2.0.wp))
              : BorderRadius.only(topLeft: Radius.circular(12.0.wp), topRight: Radius.circular(2.0.wp), bottomLeft: Radius.circular(2.0.wp), bottomRight: Radius.circular(2.0.wp)),
        ),
        child: first
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current balance', style: AppStyle.shortHeading.copyWith(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: Dimens.font_14sp, fontFamily: 'Graphik')),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Image.asset(AppImages.coins),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Obx(
                        () => Text(_homeManager.redeemablePoints.toString(),
                            style: AppStyle.shortHeading.copyWith(fontWeight: FontWeight.w500, color: AppColors.white, fontSize: Dimens.font_24sp, fontFamily: 'Graphik')),
                      ),
                      Text(' Points', style: AppStyle.shortHeading.copyWith(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: Dimens.font_16sp, fontFamily: 'Graphik')),
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
                      Text('Total earned : ', style: AppStyle.shortHeading.copyWith(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: Dimens.font_14sp, fontFamily: 'Graphik')),
                      Obx(
                        () => Text(_homeManager.pointsEarned.toString(),
                            style: AppStyle.shortHeading.copyWith(fontWeight: FontWeight.w500, color: AppColors.white, fontSize: Dimens.font_24sp, fontFamily: 'Graphik')),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Total redeemed : ', style: AppStyle.shortHeading.copyWith(fontWeight: FontWeight.w400, color: AppColors.white, fontSize: Dimens.font_14sp, fontFamily: 'Graphik')),
                      Obx(
                        () => Text(_homeManager.pointsRedeemed.toString(),
                            style: AppStyle.shortHeading.copyWith(fontWeight: FontWeight.w500, color: AppColors.white, fontSize: Dimens.font_24sp, fontFamily: 'Graphik')),
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
      decoration: BoxDecoration(color: AppColors.backGrounddarkheader, borderRadius: BorderRadius.circular(2.0.wp)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ways to redeem :',
            style: AppStyle.shortHeading.copyWith(fontSize: Dimens.font_14sp, fontWeight: FontWeight.w500, color: Colors.white, fontFamily: 'Graphik', letterSpacing: 0.5),
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
          style: AppStyle.shortHeading.copyWith(fontSize: Dimens.font_12sp, fontWeight: FontWeight.w400, fontFamily: 'Graphik', color: AppColors.textColorshade, letterSpacing: 0.5),
        ),
      ],
    );
  }

  // redeem points container ------------------------

  Widget redeemPoints({VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(MRouter.loyaltyPoints);
      },
      child: Container(
        height: 8.0.hp,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2.0.wp)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'redeem_points_now'.tr,
                style: AppStyle.shortHeading.copyWith(
                  fontSize: Dimens.font_18sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.butngradient1,
                  fontFamily: 'Graphik',
                ),
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
      height: 28.0.wp,
      margin: EdgeInsets.all(2.0.hp),
      padding: EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(
            2.0.wp,
          ),
          image: DecorationImage(image: AssetImage(AppImages.nearestAtmBg), fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find the nearest India1 ATM',
            style: AppStyle.shortHeading.copyWith(fontSize: Dimens.font_16sp, fontWeight: FontWeight.w600, color: Colors.black, letterSpacing: 0.5),
          ),
          SizedBox(height: 1.0.hp),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '2x/3x',
                style: AppStyle.shortHeading.copyWith(fontSize: Dimens.font_16sp, color: Colors.black, letterSpacing: 0.5, fontWeight: FontWeight.w600),
              ),
              Text(
                ' rewards at ATMs',
                style: AppStyle.shortHeading.copyWith(fontSize: Dimens.font_16sp, color: Colors.black),
              ),
              SizedBox(width: 6.0.wp),
              Flexible(
                child: GestureDetector(
                  onTap: onPressed,
                  child: Container(
                    height: 4.0.hp,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.yellowgradient1, AppColors.yellowgradient2]),
                        borderRadius: BorderRadius.circular(2.0.wp)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Locate ATM',
                            style: AppStyle.shortHeading.copyWith(fontSize: Dimens.font_14sp, fontWeight: FontWeight.w500, color: AppColors.butngradient1, letterSpacing: 0.5),
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

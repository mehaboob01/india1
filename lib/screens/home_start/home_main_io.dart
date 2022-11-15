import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';

import 'package:india_one/screens/loyality_points/loyalty_page.dart';
import 'package:india_one/screens/notification/notification_screen.dart';
import 'package:india_one/widgets/common_banner.dart';
import 'package:india_one/widgets/common_heading_icon.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/theme_manager.dart';
import '../../core/data/local/shared_preference_keys.dart';
import '../../utils/custom_popup_menu.dart';
import '../../widgets/button_with_flower.dart';
import '../../widgets/carasoul_slider.dart';

import '../Pages/insurance.dart';
import '../Pages/loans.dart';
import '../Pages/payments.dart';
import '../Pages/savings.dart';
import '../onboarding_login/select_language/language_selection_io.dart';
import '../profile/profile_screen.dart';
import 'home_manager.dart';

class HomeMainIO extends StatefulWidget {
  final String fromScreen;

  const HomeMainIO({super.key, required this.fromScreen});
  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> with TickerProviderStateMixin {
  double widthIs = 0, heightIs = 0;
  HomeManager _homeManager = Get.put(HomeManager());
  final LocalAuthentication auth = LocalAuthentication();
  int profileClciked = ProfileColor.INACTIVE.index;
  String msg = "You are not authorized.";
  AnimationController? animationController;
  Animation<double>? animation;
  late OverlayEntry overlayEntry;

  get index => null;

  void showFirstTimePoints() async {
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

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? showAuth = prefs.getBool(SPKeys.SHOW_AUTH);
    String? finger = prefs.getString(SPKeys.finger);

    if (showAuth == true && finger == "  ") {
      {
        try {
          bool hasbiometrics =
              await auth.canCheckBiometrics; //check if there is authencations,

          if (hasbiometrics) {
            List<BiometricType> availableBiometrics =
                await auth.getAvailableBiometrics();
            if (Platform.isAndroid) {
              bool pass = await auth.authenticate(
                  localizedReason: 'Authenticate with pattern/pin/passcode',
                  biometricOnly: false);
              if (pass) {
                msg = "You are Authenticated.";
                setState(() {});
              } else {
                SystemNavigator.pop();
              }
            } else {
              if (availableBiometrics.contains(BiometricType.fingerprint)) {
                bool pass = await auth.authenticate(
                    localizedReason: 'Authenticate with fingerprint/face',
                    biometricOnly: true);
                if (pass) {
                  msg = "You are Authenicated.";
                  setState(() {});
                } else {
                  SystemNavigator.pop();
                }
              }
            }
          } else {}
        } on PlatformException catch (e) {
          SystemNavigator.pop();

          msg = "Error while opening fingerprint/face scanner";
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
    showFirstTimePoints();

    checkLogin();

    Future.delayed(Duration(seconds: 3)).then((value) => _showOverlay());
  }

  void _showOverlay() async {
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      return widget.fromScreen == 'splash'
          ? Material(
              color: AppColors.blackColor.withOpacity(0.7),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        closeOverlay();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeTransition(
                        opacity: animation!,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.55,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(AppImages.homeScreenPopUpBg))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome to',
                                style: AppStyle.shortHeading.copyWith(
                                    height: 1.2, fontSize: Dimens.font_24sp),
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
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Text(
                                'You just won',
                                style: AppStyle.shortHeading
                                    .copyWith(fontSize: Dimens.font_20sp),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimens.padding_12dp),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(AppImages.goldenHexagonal),
                                    Positioned(
                                      top: 45,
                                      child: Text(
                                        '50',
                                        style: AppStyle.shortHeading.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 40),
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
                    ),
                  ),
                ],
              ),
            )
          : Material(
              color: AppColors.blackColor.withOpacity(0.7),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        closeOverlay();
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeTransition(
                        opacity: animation!,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  AppImages.golden_hexagon_partyThing),
                              Text(
                                'Complete your profile',
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w700,
                                    // height: 1.2,
                                    // letterSpacing: 1.2,
                                    color: Color(0xffF2642C),
                                    fontSize: Dimens.font_24sp),
                              ),
                              // Text(
                              //   'Program',
                              //   style: AppStyle.shortHeading.copyWith(
                              //       fontWeight: FontWeight.w600,
                              //       height: 1.2,

                              //       fontSize: Dimens.font_20sp),
                              // ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Text(
                                'You have a chance to',
                                style: AppStyle.shortHeading.copyWith(
                                    height: 1.2,
                                    color: AppColors.blackColor,
                                    fontSize: Dimens.font_20sp),
                              ),
                              Text(
                                'earn upto',
                                style: AppStyle.shortHeading.copyWith(
                                    fontSize: Dimens.font_20sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blackColor),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimens.padding_12dp),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(AppImages.goldenHexagonal),
                                    Positioned(
                                      top: 45,
                                      child: Text(
                                        '50',
                                        style: AppStyle.shortHeading.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Points',
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackColor,
                                    fontSize: Dimens.font_24sp),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment(0, 3),
                                        colors: [
                                          AppColors.orangeGradient1,
                                          AppColors.orangeGradient2,
                                        ])),
                                child: Center(
                                  child: Text(
                                    'Let\'s do it',
                                    style: AppStyle.shortHeading.copyWith(
                                        fontSize: Dimens.font_16sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
    animationController!.addListener(() {
      overlayState!.setState(() {});
    });
    overlayState!.insert(overlayEntry);
    animationController!.forward();
    // await Future.delayed(const Duration(seconds: 10))
    //     .whenComplete(() => animationController!.reverse())
    //     .whenComplete(() => closeOverlay());
  }

  RxBool _isHeaderIconSelected = false.obs;

  void closeOverlay() {
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
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
      child: Obx(
        () => GestureDetector(
          onTap: () => {profileClciked == 0},
          child: Scaffold(
            body: _homeManager.isLoading.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: LoadingAnimationWidget.inkDrop(
                          size: 36,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Loading ...',
                          style: AppStyle.shortHeading.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400))
                    ],
                  )
                :
// ------------------------------- put the overlay popup here ---------------------------------------------
                SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // top container ---------------------
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              4.0.wp, 20.0.wp, 4.0.wp, 4.0.wp),
                          height: 50.0.hp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0.wp),
                                bottomRight: Radius.circular(5.0.wp)),
                            image: const DecorationImage(
                                image: AssetImage(AppImages.homebg),
                                fit: BoxFit.fill),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('welcome'.tr,
                                          style: AppStyle.shortHeading.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ),

                                    // --------------------------------------------------------------------
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // headingBox(
                                        //     text: 'Aa',
                                        //     ontap: () {
                                        //       Navigator.push(
                                        //           context,
                                        //           MaterialPageRoute(
                                        //               builder: (BuildContext
                                        //                       context) =>
                                        //                   LanguageSelectionIO(
                                        //                       'home')));
                                        //     }),
                                        // SizedBox(
                                        //   width: 2.0.wp,
                                        // ),
                                        // headingBox(
                                        //     image: AppImages.notify_icon),
                                        // SizedBox(
                                        //   width: 2.0.wp,
                                        // ),
                                        HeadingIconsBox(
                                            text: 'Aa',
                                            ontap: () {
                                              Get.to(() =>
                                                  LanguageSelectionIO('home'));
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             LanguageSelectionIO(
                                              //                 'home')));
                                            }),
                                        SizedBox(
                                          width: 2.0.wp,
                                        ),
                                        HeadingIconsBox(
                                            image: AppImages.notificationBell,
                                            ontap: () async {
                                              Get.to(
                                                  () => NotificationScreen());
                                            }),
                                        headingBox(),

                                        // GestureDetector(
                                        //   onTap: () {
                                        //     profileClciked == 1;
                                        //     showMenu<String>(
                                        //       color: Colors.red,
                                        //       context: context,
                                        //       shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.only(
                                        //                   bottomLeft:
                                        //                       Radius.circular(
                                        //                           13.0),
                                        //                   bottomRight:
                                        //                       Radius.circular(
                                        //                           13.0),
                                        //                   topLeft:
                                        //                       Radius.circular(
                                        //                           13.0))),
                                        //       position: RelativeRect.fromLTRB(
                                        //           25.0, 112.0, 16.0, 0.0),
                                        //       items: [
                                        //         PopupMenuItem(
                                        //           // onTap: () async {
                                        //           //   Get.back();
                                        //           //   return await Get.to(
                                        //           //       () => ProfileScreen());
                                        //           // },

                                        //           child: Text(
                                        //             "My Profile",
                                        //             style: AppStyle.shortHeading
                                        //                 .copyWith(
                                        //                     fontSize: Dimens
                                        //                         .font_14sp,
                                        //                     color: Colors.black,
                                        //                     fontWeight:
                                        //                         FontWeight.w400,
                                        //                     letterSpacing: 1),
                                        //           ),
                                        //         ),
                                        //         PopupMenuDivider(),
                                        //         PopupMenuItem(
                                        //           onTap: () async {
                                        //             Get.back();
                                        //             return await Get.toNamed(
                                        //                 MRouter.loyaltyPoints);
                                        //           },
                                        //           child: Text(
                                        //             "My Rewards",
                                        //             style: AppStyle.shortHeading
                                        //                 .copyWith(
                                        //                     fontSize: Dimens
                                        //                         .font_14sp,
                                        //                     color: Colors.black,
                                        //                     fontWeight:
                                        //                         FontWeight.w400,
                                        //                     letterSpacing: 1),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //       elevation: 8.0,
                                        //     ).then<void>(
                                        //         (String? itemSelected) {
                                        //       if (itemSelected == null) return;

                                        //       if (itemSelected == "1") {
                                        //       } else if (itemSelected == "2") {
                                        //         Get.toNamed(
                                        //             MRouter.loyaltyPoints);

                                        //         print("2nd itme ");
                                        //       } else if (itemSelected == "3") {
                                        //       } else {
                                        //         //code here
                                        //       }
                                        //     });
                                        //   },
                                        //   child: headingBox(
                                        //       image: AppImages.user_profile),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.0.hp),
                                Text('cashback_india1_summary'.tr,
                                    style: AppStyle.shortHeading.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
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
                        nearestAtm(),
                        // carosuel Images --------------------
                        CarasoulImages(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 6.0.wp,
                              top: 12.0.wp,
                              bottom: 2.0.wp,
                              right: 6.0.wp),
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
                          child: LoansCard(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 6.0.wp,
                              top: 12.0.wp,
                              bottom: 2.0.wp,
                              right: 6.0.wp),
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
                          child: PaymentCards(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 6.0.wp,
                              top: 12.0.wp,
                              bottom: 2.0.wp,
                              right: 6.0.wp),
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
                          child: InsuranceCard(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 6.0.wp,
                              top: 12.0.wp,
                              bottom: 2.0.wp,
                              right: 6.0.wp),
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
                          child: SavingsCard(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0.hp),
                          child: CommonBanner(),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

// heading box -----------------------------------
  Widget headingBox() {
    return Obx(() {
      return CustomPopupMenuButton<String>(
          constraints: BoxConstraints(minWidth: 120, maxWidth: 125),
          offset: Offset(-10, 45),
          onSelected: (result) {
            if (result == 'profile') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            } else if (result == 'reward') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoyaltyScreen()),
              );
            }
          },
          onEnabled: () {
            _isHeaderIconSelected.value = true;
          },
          onCanceled: () {
            _isHeaderIconSelected.value = false;
          },
          // position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13.0),
                  bottomRight: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                  topLeft: Radius.circular(13.0))),
          icon: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: _isHeaderIconSelected.value
                      ? Colors.orange
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: Image(
                image: AssetImage(AppImages.profileImage),
                color:
                    _isHeaderIconSelected.value ? Colors.white : Colors.black,
              )),
          itemBuilder: (_) => <CustomPopupMenuItem<String>>[
                CustomPopupMenuItem<String>(
                  child: Center(
                    child: Text(
                      'My Profile',
                      style: AppStyle.shortHeading
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  value: 'profile',
                ),
                CustomPopupMenuItem<String>(
                    child: Center(
                      child: Text(
                        'My Rewards',
                        style: AppStyle.shortHeading
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ),
                    value: 'reward')
              ]);
    });
    // return GestureDetector(
    //   onTap: ontap,
    //   child: Container(
    //     width: 34,
    //     height: 34,
    //     decoration: BoxDecoration(
    //         color: profileClciked == 1 ? Colors.orange : Colors.white,
    //         borderRadius: BorderRadius.circular(5)),
    //     child: text != null
    //         ? Center(
    //             child: Text(
    //             text,
    //             style: const TextStyle(fontWeight: FontWeight.bold),
    //           ))
    //         : image != null
    //             ? Center(
    //                 child: SvgPicture.asset(
    //                 image,
    //                 color: Colors.black,
    //               ))
    //             : Icon(icon),
    //   ),
    // );
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
                      SizedBox(
                        width: 4,
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
                          _homeManager.pointsRedeemed.toString(),
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
          redeemWaySub(image: AppImages.mobilRechargeSvg, text: 'Recharge'),
          redeemWaySub(image: AppImages.walletIcon, text: 'Cashback')
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
    return ButtonWithFlower(
        label: 'Redeem Points Now',
        onPressed: () => {},
        buttonWidth: double.maxFinite,
        buttonHeight: 8.0.hp,
        labelSize: 14.0.sp,
        buttonColor: AppColors.white,
        labelColor: AppColors.butngradient1,
        labelWeight: FontWeight.w600);
  }

// find nearest Atm -------------------------------
  Widget nearestAtm({VoidCallback? onPressed}) {
    return Container(
      height: 24.0.wp,
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
                fontWeight: FontWeight.w600,
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
                    fontWeight: FontWeight.w600),
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
                                fontWeight: FontWeight.w600,
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
        image: DecorationImage(
            image: AssetImage(AppImages.nearestAtmBg), fit: BoxFit.fill)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Find the nearest India1 ATM',
          style: AppStyle.shortHeading.copyWith(
              fontSize: Dimens.font_16sp,
              fontWeight: FontWeight.w600,
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
                  fontSize: Dimens.font_16sp,
                  color: Colors.black,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              ' rewards at ATMs',
              style: AppStyle.shortHeading
                  .copyWith(fontSize: Dimens.font_16sp, color: Colors.black),
            ),
            SizedBox(width: 6.0.wp),
            Flexible(
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  height: 4.0.hp,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
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
                              fontSize: Dimens.font_14sp,
                              fontWeight: FontWeight.w500,
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

enum ProfileColor { INACTIVE, ACTIVE }

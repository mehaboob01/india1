import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/map/map_manager.dart';
import 'package:india_one/screens/map/map_ui.dart';

import 'package:local_auth/local_auth.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/theme_manager.dart';
import '../../core/data/local/shared_preference_keys.dart';
import '../../widgets/button_with_flower.dart';
import '../../widgets/carasoul_slider.dart';

import '../../widgets/circular_progressbar.dart';
import '../Pages/insurance.dart';
import '../Pages/loans.dart';
import '../Pages/payments.dart';
import '../Pages/savings.dart';
import '../loyality_points/loyality_manager.dart';
import '../loyality_points/redeem_points/rp_manager.dart';
import '../onboarding_login/select_language/language_selection_io.dart';
import '../profile/controller/profile_controller.dart';
import '../profile/model/profile_details_model.dart';
import '../profile/profile_screen.dart';
import 'home_manager.dart';

class HomeMainIO extends StatefulWidget with WidgetsBindingObserver {
  bool? showPonitsPopup;
  HomeMainIO(this.showPonitsPopup);

  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //  WidgetsBinding.instance.addObserver(this); // observer
    _homeManager.callHomeApi();
   // _homeManager.sendTokens();
    cashbackCtrl.onInit();
    _profileController.getProfileData();

    // showFirstTimePoints();

    //checkLogin();
  }

  Future<bool> _handleLocationPermission() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      } else {
        Get.to(Maps());
        return true;
      }
    }
    _permissionGranted = await location.hasPermission();

    _permissionGranted = await location.requestPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      return false;
    } else if (_permissionGranted == PermissionStatus.deniedForever) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Allow application to access your location?'),
          content: const Text(
              'You need to allow location\'s access in parameters to see nearby ATM\'s'),
          actions: <Widget>[
            // if user deny again, we do nothing
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Don\'t allow'),
            ),

            // if user is agree, you can redirect him to the app parameters :)
            TextButton(
              onPressed: () {
                Geolocator.openAppSettings();
                Navigator.pop(context);
              },
              child: const Text('Allow'),
            ),
          ],
        ),
      );
      return false;
    } else {
      Get.to(Maps());
      return true;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print("state : ${state}");
    if (state == AppLifecycleState.resumed) {

      checkLogin();
    }
  }

  double widthIs = 0, heightIs = 0;
  HomeManager _homeManager = Get.put(HomeManager());
  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());
  ProfileController _profileController = Get.put(ProfileController());
  ProfileDetailsModel profileDetailsModel = ProfileDetailsModel();

  final cashbackCtrl = Get.put(CashBackController());

  final LocalAuthentication auth = LocalAuthentication();
  int profileClciked = ProfileColor.INACTIVE.index;
  String msg = "You are not authorized.";

  void showFirstTimePoints() async {
    if (_homeManager.loyalityPoints.toString() == "0") {
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
    print("check auth status${_homeManager.showAuth.value}");

    if (showAuth == true || _homeManager.showAuth.value == true) {
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
                setState(() {
                  _homeManager.showAuth.value = true;
                });
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
                  setState(() {
                    _homeManager.showAuth.value = true;
                  });
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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    // your api here
    _homeManager.callHomeApi();
  //  _homeManager.sendTokens();
    _profileController.getProfileData();
    _refreshController.loadComplete();
    cashbackCtrl.onInit();
  }

  void _onRefresh() async {
    // your api here
    _refreshController.refreshCompleted();
    _homeManager.callHomeApi();
   // _homeManager.sendTokens();
    _profileController.getProfileData();
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
          onTap: () => {Get.back(), _homeManager.isClicked.value = false},
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: _homeManager.isLoading.value
                  ? CircularProgressbar()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // top container ---------------------
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                4.0.wp, 20.0.wp, 4.0.wp, 4.0.wp),
                            height: 54.0.hp,
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
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                          children: [
                                            Text('welcome'.tr,
                                                style: AppStyle.shortHeading
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            SizedBox(width: 2,),
                                            Text( "${_profileController.profileDetailsModel.value.firstName ?? ''}",
                                                style: AppStyle.shortHeading
                                                    .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          headingBox(
                                              text: 'Aa',
                                              ontap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            LanguageSelectionIO(
                                                                'home')));
                                              }),
                                          SizedBox(
                                            width: 2.0.wp,
                                          ),
                                          GestureDetector(
                                            onTap: () => Get.toNamed(
                                                MRouter.notificationScreen),
                                            child: headingBox(
                                                image: AppImages.notify_icon),
                                          ),
                                          SizedBox(
                                            width: 2.0.wp,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _homeManager.isClicked.value =
                                                  true;
                                              showMenu<String>(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    13.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    13.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    13.0))),
                                                position: RelativeRect.fromLTRB(
                                                    25.0, 118.0, 16.0, 0.0),
                                                items: [
                                                  PopupMenuItem(
                                                    height: Get.height * 0.02,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _homeManager.showAuth
                                                            .value = false;
                                                        _homeManager.isClicked
                                                            .value = false;
                                                        Get.back();
                                                        Get.to(() =>
                                                            ProfileScreen());
                                                      },
                                                      child: Container(
                                                        height:
                                                            Get.height * 0.03,
                                                        width: double.infinity,
                                                        child: Text(
                                                          "My Profile",
                                                          style: AppStyle
                                                              .shortHeading
                                                              .copyWith(
                                                                  fontSize: Dimens
                                                                      .font_14sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  letterSpacing:
                                                                      1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuDivider(),
                                                  PopupMenuItem(
                                                    height: 0.02,
                                                    child: GestureDetector(
                                                        onTap: () => {
                                                              _homeManager
                                                                      .showAuth
                                                                      .value =
                                                                  false,
                                                              _homeManager
                                                                      .isClicked
                                                                      .value =
                                                                  false,
                                                              Get.back(),
                                                              Get.toNamed(
                                                                MRouter
                                                                    .loyaltyPoints,
                                                              ),
                                                            },
                                                        child: Container(
                                                          height:
                                                              Get.height * 0.03,
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            "My Rewards",
                                                            style: AppStyle
                                                                .shortHeading
                                                                .copyWith(
                                                                    fontSize: Dimens
                                                                        .font_14sp,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    letterSpacing:
                                                                        1),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                                elevation: 8.0,
                                              ).then<void>(
                                                  (String? itemSelected) {
                                                if (itemSelected == null) {
                                                  _homeManager.isClicked.value =
                                                      false;
                                                  return;
                                                }

                                                if (itemSelected == "1") {
                                                } else if (itemSelected ==
                                                    "2") {
                                                  Get.toNamed(
                                                      MRouter.loyaltyPoints);

                                                  print("2nd itme ");
                                                } else if (itemSelected ==
                                                    "3") {
                                                } else {
                                                  //code here
                                                }
                                              });
                                            },
                                            child: headingBox(
                                                color:
                                                    _homeManager.isClicked.value
                                                        ? Colors.orange
                                                        : Colors.white,
                                                image: AppImages.user_profile),
                                          ),
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
                                  SizedBox(height: 1.0.hp),
                                  Obx(
                                    () => Visibility(
                                      visible:
                                          _homeManager.redeemablePoints <= 14
                                              ? true
                                              : false,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Note : You can redeem only if you have 15 or more points',
                                          style: AppStyle.shortHeading.copyWith(
                                            fontSize: Dimens.font_12sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 1.0.hp),
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
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

// heading box -----------------------------------
  Widget headingBox(
      {IconData? icon,
      String? image,
      String? text,
      VoidCallback? ontap,
      Color? color}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: text != null
            ? Center(
                child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ))
            : image != null
                ? Center(
                    child: SvgPicture.asset(
                    image,
                    color: Colors.black,
                  ))
                : Icon(icon),
      ),
    );
  }

  // balance card ----------------------------------------------
  Widget balanceCard({required bool first}) {
    return Container(
        padding: EdgeInsets.all(1.0.wp),
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
                        fontSize: Dimens.font_14sp,
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
                              fontSize: Dimens.font_16sp,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        ' Points',
                        style: AppStyle.shortHeading.copyWith(
                            fontSize: Dimens.font_14sp,
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
                            fontSize: Dimens.font_14sp,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                      Obx(
                        () => Text(
                          _homeManager.pointsEarned.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: Dimens.font_16sp,
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
                            fontSize: Dimens.font_14sp,
                            color: Colors.white,
                            letterSpacing: 0.2),
                      ),
                      Obx(
                        () => Text(
                          _homeManager.pointsRedeemed.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: Dimens.font_16sp,
                              color: Colors.white,
                              letterSpacing: 0.2,
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
          redeemWaySub(
              image: AppImages.mobilRechargeSvg,
              text: 'Recharge',
              routName: MRouter.mobileRechargeIO),
          redeemWaySub(
              image: AppImages.walletIcon,
              text: 'Cashback',
              routName: MRouter.cashBackRedeemPage)
        ],
      ),
    );
  }

  Widget redeemWaySub(
      {required String image, required String text, required String routName}) {
    return GestureDetector(
      onTap: () {
        _homeManager.showAuth.value = false;
        _loyaltyManager.callLoyaltyDashboardApi();

        _homeManager.redeemablePoints >= 14
            ? Get.toNamed(routName)
            : Get.snackbar(
                'Oops!!', 'You can redeem only if you have 15+ points',
                snackPosition: SnackPosition.BOTTOM);
      },
      child: Container(
        child: Row(
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
        ),
      ),
    );
  }
  // redeem points container ------------------------

  Widget redeemPoints({VoidCallback? onPressed}) {
    return ButtonWithFlower(
        label: _homeManager.redeemablePoints >= 14
            ? 'Redeem Points Now'
            : 'Earn more points',
        onPressed: () => {
              _homeManager.redeemablePoints >= 14
                  ? Get.toNamed(MRouter.redeemPointsPage)
                  : Get.toNamed(MRouter.map)
            },
        buttonWidth: double.maxFinite,
        buttonHeight: 8.0.hp,
        labelSize: 14.0.sp,
        buttonColor: AppColors.white,
        labelColor: AppColors.butngradient1,
        labelWeight: FontWeight.w600);
  }

  MapManager mapManager = Get.put(MapManager());

// find nearest Atm -------------------------------
  Widget nearestAtm() {
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
                  onTap: () async {
                    await _handleLocationPermission();
                  },
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
          Get.back();
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

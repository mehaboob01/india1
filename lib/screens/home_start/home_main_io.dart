import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cb_manager.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

import 'package:local_auth/local_auth.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/theme_manager.dart';
import '../../core/data/local/shared_preference_keys.dart';
import '../../widgets/button_with_flower.dart';
import '../../widgets/carasoul_slider.dart';

import '../../widgets/circular_progressbar.dart';
import '../../widgets/common_heading_action_icons.dart';
import '../Pages/insurance.dart';
import '../Pages/loans.dart';
import '../Pages/payments.dart';
import '../Pages/savings.dart';
import '../loyality_points/loyality_manager.dart';
import '../loyality_points/redeem_points/rp_manager.dart';
import '../map/map/map_manager.dart';
import '../map/map/map_ui.dart';
import '../notification/notification_manager.dart';
import '../onboarding_login/select_language/language_selection_io.dart';
import '../profile/controller/profile_controller.dart';
import '../profile/profile_screen.dart';
import 'home_manager.dart';
import 'dart:io' show Platform;

class HomeMainIO extends StatefulWidget with WidgetsBindingObserver {
  bool? showPonitsPopup;
  List<FocusNode> focusNodes;
  HomeMainIO(this.showPonitsPopup, this.focusNodes);

  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> with WidgetsBindingObserver {
  final cashbackManager = Get.put(CashBackManager());
  final notificationManager = Get.put(NotificationManager());
  ProfileController _profileController = Get.put(ProfileController());

  int androidVersion = 0;

  getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.version.release}');
    androidVersion = int.tryParse(androidInfo.version.release)!;

  }



  final ConnectionManagerController _controller =
  Get.find<ConnectionManagerController>();



  @override
  void initState() {
    super.initState();
    getAndroidVersion();
    _profileController.getProfileData();
    _profileController.setData();

    WidgetsBinding.instance.addPostFrameCallback((_) {

       WidgetsBinding.instance.addObserver(this); // observer
      _homeManager.callHomeApi();
      _profileController.getProfileData();
    //  _homeManager.callAdsBannerApi();
      notificationManager.callNotificationsApi(false);

      // _homeManager.sendTokens();
      _loyaltyManager.callLoyaltyDashboardApi();
      cashbackCtrl.onInit();
      cashbackManager.callBankListApi();
      _profileController.getProfileData();

      showFirstTimePoints();

      checkLogin();
    });

  }

  Future<bool> _handleLocationPermission() async {
    bool _serviceEnabled;
    Location location = new Location();
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    _permissionGranted = await location.requestPermission();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? firstInit =
        sharedPreferences.getBool(SPKeys.FIRST_INIT_LOCATION_PERMISSION);
    if (_permissionGranted == PermissionStatus.denied) {
      if (firstInit != null) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_LOCATION_PERMISSION, true);
      }
      return false;
    } else if (_permissionGranted == PermissionStatus.granted ||
        _permissionGranted == PermissionStatus.grantedLimited) {
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return false;
        } else {
          Get.to(Maps());
          return true;
        }
      }
      Get.to(Maps());
      return false;
    } else if (_permissionGranted == PermissionStatus.deniedForever) {
      if (firstInit == null || firstInit) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_LOCATION_PERMISSION, false);
        return false;
      }
      Geolocator.openAppSettings();
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
    if (state == AppLifecycleState.resumed && androidVersion>8) {
      checkLogin();
    }
  }

  double widthIs = 0, heightIs = 0;
  HomeManager _homeManager = Get.put(HomeManager());
  CashBackManager _cashBackManager = Get.put(CashBackManager());
  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());

  final cashbackCtrl = Get.put(CashBackController());

  final LocalAuthentication auth = LocalAuthentication();
  int profileClciked = ProfileColor.INACTIVE.index;
  String msg = "You are not authorized.";

  void showFirstTimePoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? points = prefs.getInt(SPKeys.LOYALTY_POINT_GAINED);

    if (points != 0) {
      Future.delayed(
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
                            image: AssetImage(AppImages.homeScreenPopUpBg))),
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
                            height: MediaQuery.of(context).size.height * 0.05),
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
                                child: Obx(
                                  () => Text(
                                    _homeManager.loyalityPoints.toString(),
                                    style: AppStyle.shortHeading.copyWith(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 40),
                                  ),
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
              ).show()).then(
          (value) => prefs!.setInt(SPKeys.LOYALTY_POINT_GAINED, 0));
    }
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? showAuth = prefs.getBool(SPKeys.SHOW_AUTH);
    String? finger = prefs.getString(SPKeys.finger);
    print("check auth fggfgfgf status${_homeManager.showAuth.value}");

    if (showAuth == true) {
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
                    WidgetsBinding.instance.removeObserver(this);
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
                    WidgetsBinding.instance.removeObserver(this);
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
    _homeManager.callAdsBannerApi();
    //  _homeManager.sendTokens();
    _profileController.getProfileData();
    _refreshController.loadComplete();
    _loyaltyManager.callLoyaltyDashboardApi();

    cashbackCtrl.onInit();
  }

  void _onRefresh() async {
    // your api here
    _refreshController.refreshCompleted();
    _homeManager.callHomeApi();
    _homeManager.callAdsBannerApi();
    _loyaltyManager.callLoyaltyDashboardApi();

    // _homeManager.sendTokens();
    _profileController.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(
            const Duration(seconds: 0),
            () async => Get.defaultDialog(
                  cancelTextColor: AppColors.white,
                  title: "Logout",
                  middleText: "Do you want to close the app?",
                  // textConfirm: "Yes",
                  // textCancel: "No",
                  // confirm: await confirmBtn(),
                  // cancel: await cancelBtn(),
                  actions: [
                    confirmBtn(),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();

                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text("No"))
                  ],
                  radius: 8,
                  backgroundColor: AppColors.primary,
                  titleStyle: TextStyle(
                      color: Colors.white, fontSize: Dimens.font_14sp),
                  middleTextStyle: TextStyle(
                      color: Colors.white, fontSize: Dimens.font_12sp),
                ));
        return false;
      },
      child: Obx(
        () => IgnorePointer(
          ignoring: _controller.ignorePointer.value,
          child: GestureDetector(
            onTap: () => {Get.back(), _homeManager.isClicked.value = false},
            child: SafeArea(
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
                              // CustomAppBar(
                              //   heading: '',
                              //   hasLogo: true,
                              //   haveHomeIcons: true,
                              //   actionIcons: [
                              //     Focus(
                              //       focusNode: widget.focusNodes[5],
                              //       child: HeadingBox(
                              //           text: 'Aa',
                              //           color: Color(0xff004280),
                              //           ontap: () {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder:
                              //                         (BuildContext context) =>
                              //                             LanguageSelectionIO(
                              //                                 'home')));
                              //           }),
                              //     ),
                              //     Badge(
                              //         position: BadgePosition.topEnd(
                              //             top: -10, end: 0),
                              //         badgeColor: Colors.red,
                              //         showBadge: notificationManager
                              //                 .notificationsCount.length
                              //                 .toInt() !=
                              //             0,
                              //         badgeContent: Container(
                              //           child: Text(
                              //             "",
                              //             style: TextStyle(color: Colors.white),
                              //           ),
                              //         ),
                              //         child: Focus(
                              //           focusNode: widget.focusNodes[6],
                              //           child: HeadingBox(
                              //             image: AppImages.notify_icon,
                              //             color: AppColors.blueColor,
                              //             ontap: () => Get.toNamed(
                              //                 MRouter.notificationScreen),
                              //           ),
                              //         )),
                              //     Focus(
                              //       focusNode: widget.focusNodes[7],
                              //       child: HeadingBox(
                              //         color: _homeManager.isClicked.value
                              //             ? Colors.orange
                              //             : AppColors.blueColor,
                              //         image: AppImages.user_profile,
                              //         ontap: () {
                              //           _homeManager.isClicked.value = true;
                              //           showMenu<String>(
                              //             context: context,
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius: BorderRadius.only(
                              //                     bottomLeft:
                              //                         Radius.circular(13.0),
                              //                     bottomRight:
                              //                         Radius.circular(13.0),
                              //                     topLeft:
                              //                         Radius.circular(13.0))),
                              //             position: RelativeRect.fromLTRB(
                              //                 25.0, 100.0, 16.0, 0.0),
                              //             items: [
                              //               PopupMenuItem(
                              //                 height: Get.height * 0.02,
                              //                 child: GestureDetector(
                              //                   onTap: () {
                              //                     _homeManager.showAuth.value =
                              //                         false;
                              //                     _homeManager.isClicked.value =
                              //                         false;
                              //                     Get.back();
                              //                     Get.to(() => ProfileScreen());
                              //                   },
                              //                   child: Container(
                              //                     height: Get.height * 0.03,
                              //                     width: double.infinity,
                              //                     child: Text(
                              //                       "My Profile",
                              //                       style: AppStyle.shortHeading
                              //                           .copyWith(
                              //                               fontSize: Dimens
                              //                                   .font_14sp,
                              //                               color: Colors.black,
                              //                               fontWeight:
                              //                                   FontWeight.w400,
                              //                               letterSpacing: 1),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               PopupMenuDivider(),
                              //               PopupMenuItem(
                              //                 height: 0.02,
                              //                 child: GestureDetector(
                              //                     onTap: () => {
                              //                           _homeManager.showAuth
                              //                               .value = false,
                              //                           _homeManager.isClicked
                              //                               .value = false,
                              //                           Get.back(),
                              //                           Get.toNamed(
                              //                             MRouter.loyaltyPoints,
                              //                           ),
                              //                         },
                              //                     child: Container(
                              //                       height: Get.height * 0.03,
                              //                       width: double.infinity,
                              //                       child: Text(
                              //                         "My Rewards",
                              //                         style: AppStyle
                              //                             .shortHeading
                              //                             .copyWith(
                              //                                 fontSize:
                              //                                     Dimens
                              //                                         .font_14sp,
                              //                                 color:
                              //                                     Colors.black,
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .w400,
                              //                                 letterSpacing: 1),
                              //                       ),
                              //                     )),
                              //               ),
                              //             ],
                              //             elevation: 8.0,
                              //           ).then<void>((String? itemSelected) {
                              //             if (itemSelected == null) {
                              //               _homeManager.isClicked.value =
                              //                   false;
                              //               return;
                              //             }

                              //             if (itemSelected == "1") {
                              //             } else if (itemSelected == "2") {
                              //               Get.toNamed(MRouter.loyaltyPoints);

                              //               print("2nd itme ");
                              //             } else if (itemSelected == "3") {
                              //             } else {
                              //               //code here
                              //             }
                              //           });
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // top container ---------------------
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    4.0.wp, 4.0.wp, 4.0.wp, 4.0.wp),
                                height: 50.0.hp,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5.0.wp),
                                        bottomRight: Radius.circular(5.0.wp)),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(AppImages.newHomeBgPng),
                                        fit: BoxFit.cover)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CommonRoundedLogo(),
                                            Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Focus(
                                                    focusNode:
                                                        widget.focusNodes[5],
                                                    child: HeadingBox(
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
                                                  ),
                                                  SizedBox(
                                                    width: 2.0.wp,
                                                  ),
                                                  notificationManager
                                                              .notificationsCount
                                                              .length
                                                              .toInt() !=
                                                          0
                                                      ? Focus(
                                                          focusNode: widget
                                                              .focusNodes[6],
                                                          child:
                                                              GestureDetector(
                                                            onTap: () => Get
                                                                .toNamed(MRouter
                                                                    .notificationScreen),
                                                            child: Badge(
                                                              position:
                                                                  BadgePosition
                                                                      .topEnd(
                                                                          top:
                                                                              -10,
                                                                          end:
                                                                              0),
                                                              badgeColor:
                                                                  Colors.red,
                                                              badgeContent:
                                                                  Container(
                                                                child: Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              child: HeadingBox(
                                                                  image: AppImages
                                                                      .notify_icon),
                                                            ),
                                                          ),
                                                        )
                                                      : Focus(
                                                          focusNode: widget
                                                              .focusNodes[6],
                                                          child:
                                                              GestureDetector(
                                                            onTap: () => Get
                                                                .toNamed(MRouter
                                                                    .notificationScreen),
                                                            child: HeadingBox(
                                                                image: AppImages
                                                                    .notify_icon),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 2.0.wp,
                                                  ),
                                                  Focus(
                                                    focusNode:
                                                        widget.focusNodes[7],
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _homeManager.isClicked
                                                            .value = true;
                                                        showMenu<String>(
                                                          context: context,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          13.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          13.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          13.0))),
                                                          position: RelativeRect
                                                              .fromLTRB(
                                                                  25.0,
                                                                  118.0,
                                                                  16.0,
                                                                  0.0),
                                                          items: [
                                                            PopupMenuItem(
                                                              height:
                                                                  Get.height *
                                                                      0.02,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  _homeManager
                                                                      .showAuth
                                                                      .value = false;
                                                                  _homeManager
                                                                      .isClicked
                                                                      .value = false;
                                                                  Get.back();
                                                                  Get.to(() =>
                                                                      ProfileScreen());
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      Get.height *
                                                                          0.03,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Text(
                                                                    "My Profile",
                                                                    style: AppStyle.shortHeading.copyWith(
                                                                        fontSize:
                                                                            Dimens
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
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () =>
                                                                              {
                                                                                _homeManager.showAuth.value = false,
                                                                                _homeManager.isClicked.value = false,
                                                                                Get.back(),
                                                                                Get.toNamed(
                                                                                  MRouter.loyaltyPoints,
                                                                                ),
                                                                              },
                                                                      child:
                                                                          Container(
                                                                        height: Get.height *
                                                                            0.03,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          "My Rewards",
                                                                          style: AppStyle.shortHeading.copyWith(
                                                                              fontSize: Dimens.font_14sp,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w400,
                                                                              letterSpacing: 1),
                                                                        ),
                                                                      )),
                                                            ),
                                                          ],
                                                          elevation: 8.0,
                                                        ).then<void>((String?
                                                            itemSelected) {
                                                          if (itemSelected ==
                                                              null) {
                                                            _homeManager
                                                                .isClicked
                                                                .value = false;
                                                            return;
                                                          }

                                                      if (itemSelected == "1") {
                                                      } else if (itemSelected ==
                                                          "2") {
                                                        Get.toNamed(MRouter
                                                            .loyaltyPoints);

                                                            print("2nd itme ");
                                                          } else if (itemSelected ==
                                                              "3") {
                                                          } else {
                                                            //code here
                                                          }
                                                        });
                                                      },
                                                      child: HeadingBox(
                                                          color: _homeManager
                                                                  .isClicked
                                                                  .value
                                                              ? Colors.orange
                                                              : Colors.white,
                                                          imgColor: _homeManager
                                                                  .isClicked
                                                                  .value
                                                              ? Colors.white
                                                              : Colors.black,
                                                          image: AppImages
                                                              .user_profile),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2.0.hp),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('welcome'.tr,
                                              style: AppStyle.shortHeading
                                                  .copyWith(
                                                color: Colors.white,
                                              )),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                              "${_profileController.profileDetailsModel.value.firstName ?? ''}",
                                              style: AppStyle.shortHeading
                                                  .copyWith(
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 1.0.hp),
                                      Text('cashback_india1_summary'.tr,
                                          style: AppStyle.shortHeading.copyWith(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 2.0.hp),
                                      // balance card --------------------------
                                      Row(
                                        children: [
                                          Expanded(
                                              child: balanceCard(first: true)),
                                          SizedBox(width: 2.0.wp),
                                          Expanded(
                                              child: balanceCard(first: false))
                                        ],
                                      ),
                                      // ways to Reedem ---------------------------------
                                      SizedBox(height: 1.0.hp),
                                      // Obx(
                                      //   () => Visibility(
                                      //     visible:
                                      //         _homeManager.redeemablePoints <= 14
                                      //             ? true
                                      //             : false,
                                      //     child: Padding(
                                      //       padding:
                                      //           const EdgeInsets.only(left: 4.0),
                                      //       child: Text(
                                      //         'Note : You can redeem only if you have 15 or more points',
                                      //         style: AppStyle.shortHeading.copyWith(
                                      //           fontSize: Dimens.font_12sp,
                                      //           color: Colors.white,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(height: 1.0.hp),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.0.wp),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.0.wp),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.0.wp),
                                child: InsuranceCard(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 6.0.wp, top: 12.0.wp, right: 6.0.wp),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.0.wp, vertical: 2.0.wp),
                                child: SavingsCard(),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// heading box -----------------------------------

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
        label: _homeManager.redeemablePoints >= 15
            ? 'Redeem Points Now'
            : 'Earn More Points',
        onPressed: () => _homeManager.redeemablePoints >= 15
            ? {Get.toNamed(MRouter.redeemPointsPage)}
            : {
                // Get.toNamed(MRouter.map)
                Get.snackbar(
                    'Oops!!', 'You can redeem only if you have 15+ points',
                    snackPosition: SnackPosition.BOTTOM)
              },
        buttonWidth: double.maxFinite,
        buttonHeight: 8.0.hp,
        labelSize: 14.0.sp,
        buttonColor: AppColors.white,
        labelColor: AppColors.blueColor,
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
                    Location location = new Location();
                    PermissionStatus _permissionGranted;
                    _permissionGranted = await location.hasPermission();

                    if (_permissionGranted == PermissionStatus.deniedForever ||
                        _permissionGranted == PermissionStatus.denied) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Location Access'),
                          content: Text(
                              "India1 collects current location data to enable the user to see near by India1 ATM's when the app is in use."),
                          actions: <Widget>[
                            // if user deny again, we do nothing
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Don\'t allow'),
                            ),

                            // if user is agree, you can redirect him to the app parameters :)
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await _handleLocationPermission();
                              },
                              child: const Text('Allow'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Get.toNamed(MRouter.map);
                    }
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
                                color: AppColors.blueColor,
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
                              color: AppColors.blueColor,
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
          Navigator.of(Get.context!, rootNavigator: true).pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
      child: Text("Yes"));
}

Widget cancelBtn() {
  return ElevatedButton(
      onPressed: () {
        print("Go back");
        Get.back();
      },
      child: Text("No"));
}

enum ProfileColor { INACTIVE, ACTIVE }

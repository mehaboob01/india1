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
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/popUps_page.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cb_manager.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:local_auth/error_codes.dart';

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

import '../map/map_ui.dart';
import '../notification/notification_manager.dart';
import '../onboarding_login/select_language/language_selection_io.dart';
import '../profile/controller/profile_controller.dart';
import '../profile/profile_screen.dart';
import 'home_manager.dart';
import 'dart:io' show Platform;

class HomeMainIO extends StatefulWidget with WidgetsBindingObserver {
  bool? showPonitsPopup;
  List<FocusNode>? focusNodes;
  HomeMainIO(this.showPonitsPopup, this.focusNodes);

  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> with WidgetsBindingObserver {
  final cashbackManager = Get.put(CashBackManager());
  final notificationManager = Get.put(NotificationManager());
  ProfileController _profileController = Get.put(ProfileController());
  CashBackManager cashBackManager = Get.put(CashBackManager());


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


      DioApiCall().refreshToken();
     cashBackManager.fetchCustomerBankAccounts();
     cashBackManager.fetchCustomerUpiAccounts();
      getAndroidVersion();
      _profileController.getProfileData();
      _profileController.setData();
      WidgetsBinding.instance.addPostFrameCallback((_) {



        if (androidVersion > 10) {
          WidgetsBinding.instance.addObserver(this);
        }
        // observer
        _homeManager.callHomeApi();
        _profileController.getProfileData();
        //  _homeManager.callAdsBannerApi();
        notificationManager.callNotificationsApi(false);

        // _homeManager.sendTokens();
        _loyaltyManager.callLoyaltyDashboardApi();
        cashbackCtrl.onInit();
        cashbackManager.callBankListApi();
        _profileController.getProfileData();
        _profileController.setData();

        showFirstTimePoints();
        // showCompleteProfile();
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

      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: text("Location Access"),
              content: text(

                  "You need to allow location permissions to see nearby ATM's, please allow the permission in settings to proceed.",maxLines: 5),
              actions: [
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Geolocator.openAppSettings();
                      },
                      child: text(
                        "Open application settings",
                        color: Colors.blue
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: text(
                        "Cancel",
                          color: Colors.blue
                      ),
                    ),
                  ],
                ),
              ],
            );
          }));
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
    if (state == AppLifecycleState.resumed &&
        androidVersion > 8 &&
        androidVersion != 10) {
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
      return DisplayPopuP()
          .welcomepopup(context: context, welcomePoints: points.toString())
          .then((value) => prefs!.setInt(SPKeys.LOYALTY_POINT_GAINED, 0));
    }
  }

  void showCompleteProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? points = prefs.getInt(SPKeys.LOYALTY_POINT_PROFILE);
    int? count = prefs.getInt(SPKeys.COMPLETE_PROFILE_COUNT);

    if (points != null) {
      if (_profileController.profileDetailsModel.value.firstName.toString() ==
              null &&
          count == 0) {
        return DisplayPopuP()
            .getProfileWelcome(
                context: context, profilePoints: points.toString())
            .then((value) => prefs!.setInt(SPKeys.COMPLETE_PROFILE_COUNT, 1));
      }
    }
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? showAuth = prefs.getBool(SPKeys.SHOW_AUTH);
    String? finger = prefs.getString(SPKeys.finger);
    print("check auth fggfgfgf status${_homeManager.showAuth.value}");
    try {
      //--------------------
      if (showAuth == true) {
        List<BiometricType> availableBiometric =
        await auth.getAvailableBiometrics();
        print("availableBiometric $availableBiometric");
        //---------------
        if (availableBiometric.isEmpty) {
          //---------------
          bool pass = await auth.authenticate(
              localizedReason: 'Authenticate with pattern/pin/passcode',
              options: AuthenticationOptions(
                biometricOnly: false,
              ));

          if (pass) {
            msg = "You are Authenticated.";
            setState(() {
              _homeManager.showAuth.value = true;
              WidgetsBinding.instance.removeObserver(this);
            });
          } else {
            if (androidVersion == 10) {
              auth.stopAuthentication();
              WidgetsBinding.instance.removeObserver(this);
              SystemNavigator.pop();
            }
            SystemNavigator.pop();
          }
          //----------------
        } else {
          if (availableBiometric.contains(BiometricType.fingerprint)) {
            bool pass = await auth.authenticate(
                localizedReason: 'Authenticate with fingerprint/face',
                options: AuthenticationOptions(
                  biometricOnly: true,
                  stickyAuth: true,
                ));
            if (pass) {
              msg = "You are Authenicated.";
              setState(() {
                _homeManager.showAuth.value = true;
                WidgetsBinding.instance.removeObserver(this);
              });
            } else {
              if (androidVersion == 10) {
                auth.stopAuthentication();
                WidgetsBinding.instance.removeObserver(this);
                SystemNavigator.pop();
              }
              SystemNavigator.pop();
            }
          } else {
            //when list is not empty and doesnt have fingerprint
            //---------
            bool pass = await auth.authenticate(
                localizedReason: 'Authenticate with pattern/pin/passcode',
                options: AuthenticationOptions(biometricOnly: false));
            if (pass) {
              msg = "You are Authenticated.";
              setState(() {
                _homeManager.showAuth.value = true;
                WidgetsBinding.instance.removeObserver(this);
              });
            } else {
              if (androidVersion == 10) {
                bool pass = await auth.authenticate(
                    localizedReason: 'Authenticate with pattern/pin/passcode',
                    options: AuthenticationOptions(biometricOnly: false));
                if (pass) {
                  msg = "You are Authenticated.";
                  setState(() {
                    _homeManager.showAuth.value = true;
                    WidgetsBinding.instance.removeObserver(this);
                  });
                }
              } else {
                SystemNavigator.pop();
              }
            }
            //----------
          }
        }
        //------------------
      } else {
        auth.stopAuthentication();
        WidgetsBinding.instance.removeObserver(this);
      }
      //--------------------
    } catch (e) {
      // SystemNavigator.pop();

      if (e.toString().contains("NotAvailable")) {
        auth.stopAuthentication();
        WidgetsBinding.instance.removeObserver(this);
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
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(20),
                buttonPadding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: SvgPicture.asset(AppImages.newIndiaOneSvg),
                content: text("Do you want to exit app?",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    fontSize: Dimens.font_20sp,
                    color: Colors.black),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: text(
                          "Cancel",
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.font_16sp,
                          color: AppColors.primary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                            Navigator.of(Get.context!, rootNavigator: true)
                                .pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                        },
                        child: text(
                          "Exit",
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.font_16sp,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }));
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
                  child:  Stack(
                    children:
                    [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                                      widget.focusNodes![5],
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
                                                      .focusNodes![6],
                                                  child:
                                                  GestureDetector(
                                                    onTap: () async{
                                                    await  DioApiCall().refreshToken();
                                                    Get
                                                        .toNamed(MRouter
                                                        .notificationScreen);
                                                    },


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
                                                        child: text(
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
                                                      .focusNodes![5],
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
                                                  widget.focusNodes![6],
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
                                                                child: text(
                                                                  "my_profile"
                                                                      .tr,
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
                                                                  text(
                                                                    "my_rewards"
                                                                        .tr,
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

                                                        if (itemSelected ==
                                                            "1") {
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
                                        text('welcome'.tr,
                                            style: AppStyle.shortHeading
                                                .copyWith(
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        text(
                                            "${_profileController.profileDetailsModel.value.firstName ?? ''}",
                                            style: AppStyle.shortHeading
                                                .copyWith(
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 1.0.hp),
                                    text('cashback_summary'.tr,
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
                                    //       child: text(
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
                            _homeManager.bannerList.isEmpty?SizedBox.shrink():  CarasoulImages(),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 6.0.wp,
                                  top: 12.0.wp,
                                  bottom: 2.0.wp,
                                  right: 6.0.wp),
                              child: text(
                                'loans'.tr,
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
                              child: text(
                                'payments'.tr,
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
                              child: text(
                                'insurance'.tr,
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
                              child: text(
                                'savings'.tr,
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
                      _homeManager.isLoading.value == true? CircularProgressbar() : SizedBox()


                    ]
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
        padding: EdgeInsets.all(3.0.wp),
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
                  text(
                    'current_balance'.tr,
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
                        () => text(
                          _homeManager.redeemablePoints.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: Dimens.font_16sp,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      text(
                        'point'.tr,
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
                      text(
                        'total_earned'.tr,
                        style: AppStyle.shortHeading.copyWith(
                          fontSize: Dimens.font_14sp,
                          color: Colors.white,
                        ),
                      ),
                      Obx(
                        () => text(
                          _homeManager.pointsEarned.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: Dimens.font_14sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      text(
                        'total_redeemed'.tr,
                        style: AppStyle.shortHeading.copyWith(
                          fontSize: Dimens.font_14sp,
                          color: Colors.white,
                        ),
                      ),
                      Obx(
                        () => text(
                          _homeManager.pointsRedeemed.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: Dimens.font_14sp,
                              color: Colors.white,
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
          text(
            'ways_to_reddem'.tr,
            style: AppStyle.shortHeading.copyWith(
                fontSize: 10.0.sp, color: Colors.white, letterSpacing: 0.5),
          ),
          redeemWaySub(
              image: AppImages.mobilRecharge2Svg,
              text: 'recharge'.tr,
              routName: MRouter.mobileRechargeIO),
          redeemWaySub(
              image: AppImages.walletIcon,
              text: 'cashback'.tr,
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
                'Oops!!', 'You can redeem only if you have 15 or more points',
                snackPosition: SnackPosition.BOTTOM);
      },
      child: Container(
        child: Row(
          children: [
            SvgPicture.asset(image),
            SizedBox(width: 1.0.wp),
            Text(
              text,
              textScaleFactor: 1,
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
            ? 'redeem_points_now'.tr
            : 'Earn More Points',
        onPressed: () => _homeManager.redeemablePoints >= 15
            ? {Get.toNamed(MRouter.redeemPointsPage)}
            : {
                // Get.toNamed(MRouter.map)
                Get.snackbar('Oops!!',
                    'You can redeem only if you have 15 or more points',
                    snackPosition: SnackPosition.BOTTOM)
              },
        buttonWidth: double.maxFinite,
        buttonHeight: 8.0.hp,
        labelSize: 14.0.sp,
        buttonColor: AppColors.white,
        labelColor: AppColors.blueColor,
        labelWeight: FontWeight.w600);
  }

  // MapManager mapManager = Get.put(MapManager());

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
          text(
            'find_nearest_atm'.tr,
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
              text(
                '2x/3x',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600),
              ),
              text(
                'rewads_at_atm'.tr,
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
                      _handleLocationPermission();
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
                          child: text(
                            'locate_atm'.tr,
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
        text(
          'find_nearest_atm'.tr,
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
            text(
              '2x/3x',
              style: AppStyle.shortHeading.copyWith(
                  fontSize: Dimens.font_16sp,
                  color: Colors.black,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600),
            ),
            text(
              'locate_atm'.tr,
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
                        child: text(
                          'locate_atm'.tr,
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
      child: text("Yes"));
}

Widget cancelBtn() {
  return ElevatedButton(
      onPressed: () {
        print("Go back");
        Get.back();
      },
      child: text("No"));
}

enum ProfileColor { INACTIVE, ACTIVE }

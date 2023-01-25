import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/loyality_points/redeem_points/rp_ui.dart';

import 'package:india_one/widgets/common_banner.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/your_reward_card.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/theme_manager.dart';
import '../../utils/common_methods.dart';
import 'loyality_manager.dart';

class LoyaltyScreen extends StatefulWidget {
  @override
  State<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen>
    with TickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late OverlayEntry _overlayEntry;
  AnimationController? animationController;
  Animation<double>? animation;
  final loyaltyManager = Get.find<LoyaltyManager>();

  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        CurveTween(curve: Curves.decelerate).animate(animationController!);
  }

  void _onLoading() async {
    // your api here
    // _loyaltyManager.callLoyaltyDashboardApi();
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    //  _loyaltyManager.callLoyaltyDashboardApi();
    _refreshController.refreshCompleted();

    // your api here
  }

  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  // overlay entery --------------------------------------
  void _showOverlay(
    int points,
    String expireDate,
    RewardState rewardState,
    Rewardtype rewardType,
  ) {
    OverlayState? _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: FadeTransition(
          opacity: animation!,
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.black.withOpacity(0.7),
            child: Stack(
              children: [
                Positioned(
                  top: Get.height * 0.05,
                  right: Get.width * 0.01,
                  child: IconButton(
                      onPressed: () => animationController!.reverse().then((_) {
                            _closeOverlay();
                            loyaltyManager.isOverlayOpen.value = false;
                          }),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                  top: Get.height * 0.25,
                  right: Get.width * 0.2,
                  left: Get.width * 0.2,
                  child: Container(
                      height: Get.height * 0.25,
                      width: Get.width * 0.7,
                      child: YourRewardCard(
                        rewardState: rewardState,
                        rewardtype: rewardType,
                        date: expireDate,
                        points: points,
                        isOverlay: true,
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: Get.height * 0.3,
                      width: Get.width,
                      padding: EdgeInsets.only(
                          left: 25.0, top: 15.0, right: 25.0, bottom: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 2),
                          text(
                            'You just won',
                            style: TextStyle(
                                fontSize: 12.0.sp,
                                fontFamily: AppFonts.appFont,
                                color: Colors.black),
                          ),
                          text(
                            '$points Points',
                            style: TextStyle(
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0.sp,
                                color: AppColors.pointsColor),
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'For ',
                              style: TextStyle(
                                  fontFamily: AppFonts.appFont,
                                  fontSize: 12.0.sp,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: 'cash withdrawal',
                              style: TextStyle(
                                  fontFamily: AppFonts.appFont,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.sp,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: ' at the ATM',
                              style: TextStyle(
                                  fontFamily: AppFonts.appFont,
                                  fontSize: 12.0.sp,
                                  color: Colors.black),
                            ),
                          ])),
                          SizedBox(height: 1.0.wp),
                          text(
                            'Use by $expireDate',
                            style: TextStyle(
                                fontSize: 12.0.sp,
                                fontFamily: AppFonts.appFont,
                                color: Colors.black),
                          ),
                          SizedBox(height: 1.0.wp),
                          GestureDetector(
                            onTap: () {
                              if (loyaltyManager.redeemablePoints.value >= 15) {
                                _closeOverlay();
                                loyaltyManager.isOverlayOpen.value = false;
                                Get.to(() => RedeemPointsPage());
                              } else {
                                _closeOverlay();
                                loyaltyManager.isOverlayOpen.value = false;
                                Get.snackbar('Oops!!',
                                    'You can redeem only if you have 15 or more points',
                                    snackPosition: SnackPosition.BOTTOM);
                              }

                              //Get.to(RedeemPointsPage());
                            },
                            child: Container(
                              height: 12.0.wp,
                              decoration: BoxDecoration(
                                  color: loyaltyManager.redeemablePoints.value <
                                          15
                                      ? const Color(0xffc1c1c1)
                                      : null,
                                  gradient:
                                      loyaltyManager.redeemablePoints.value >=
                                              15
                                          ? const LinearGradient(
                                              begin: Alignment(-2, 0),
                                              end: Alignment.centerRight,
                                              colors: [
                                                  AppColors.orangeGradient1,
                                                  AppColors.orangeGradient2,
                                                ])
                                          : null,
                                  borderRadius: BorderRadius.circular(2.0.wp)),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: text(
                                      'Redeem Now',
                                      style: AppStyle.shortHeading.copyWith(
                                          fontSize: 14.0.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 0.5),
                                    ),
                                  ),
                                  loyaltyManager.redeemablePoints.value >= 15
                                      ? Align(
                                          alignment: Alignment.centerRight,
                                          child: Image.asset(
                                            AppImages.bgflower,
                                            color: Colors.white,
                                            fit: BoxFit.fill,
                                          ))
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    animationController?.addListener(() {
      _overlayState!.setState(() {});
    });
    _overlayState?.insert(_overlayEntry);
    animationController!.forward();
  }

  void _closeOverlay() {
    _overlayEntry.remove();
  }

  // overlay entry close ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: WillPopScope(
            onWillPop: () async {
              if (loyaltyManager.isOverlayOpen.value == false) {
                return true;
              } else {
                loyaltyManager.isOverlayOpen.value = false;
                _closeOverlay();
                return false;
              }
              //_loyaltyManager.isOverlayOpen.value ? false : true;
            },
            child: SafeArea(
              child: SmartRefresher(
                enablePullDown: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Column(
                  children: [
                    CustomAppBar(
                      heading: 'Loyalty program',
                      hasLogo: true,
                      customActionIconsList: [
                        CustomActionIcons(
                            image: AppImages.bottomNavHomeSvg,
                            onHeaderIconPressed: () async {
                              Get.offNamedUntil(
                                  MRouter.homeScreen, (route) => route.isFirst);
                            })
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          // padding
                          padding: EdgeInsets.all(4.0.wp),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingContainer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, bottom: 6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      text(
                                        'Your rewards',
                                        style: AppStyle.shortHeading.copyWith(
                                            color: const Color(0xff2d2d2d),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              MRouter.usedRewardHistory);
                                        },
                                        // history text will be there
                                        child: text(
                                          'History', //'View used points',
                                          style: AppStyle.shortHeading.copyWith(
                                              fontSize: 10.0.sp,
                                              color: const Color(0xff2364A1),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4.0.wp),
                                Obx(
                                  () => _loyaltyManager.isLoading.value == true
                                      ? Shimmer.fromColors(
                                          baseColor: AppColors.greySecond
                                              .withOpacity(0.5),
                                          highlightColor: AppColors.darkGrey,
                                          child: ListView.builder(
                                            itemCount: _loyaltyManager
                                                .recentRewardTransactionsList
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: SizedBox(height: 80),
                                              );
                                            },
                                          ),
                                        )
                                      : _loyaltyManager
                                                  .recentRewardTransactionsList
                                                  .length ==
                                              0
                                          ? Center(
                                              child: text(
                                              "No Rewards!",
                                              style: AppStyle.shortHeading
                                                  .copyWith(
                                                      color: const Color(
                                                          0xff2d2d2d),
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ))
                                          : GridView(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 1,
                                                      crossAxisSpacing: 4.0.wp,
                                                      mainAxisSpacing: 4.0.wp),
                                              children: List.generate(
                                                _loyaltyManager
                                                    .recentRewardTransactionsList
                                                    .length,
                                                (index) => GestureDetector(
                                                  onTap: () {
                                                    _showOverlay(
                                                        _loyaltyManager
                                                            .recentRewardTransactionsList[
                                                                index]
                                                            .points!
                                                            .toInt(),
                                                        CommonMethods().getOnlyDate(
                                                            date: _loyaltyManager
                                                                .recentRewardTransactionsList[
                                                                    index]
                                                                .date),
                                                        isActive(
                                                            _loyaltyManager
                                                                .recentRewardTransactionsList[
                                                                    index]
                                                                .date!,
                                                            _loyaltyManager
                                                                .recentRewardTransactionsList[
                                                                    index]
                                                                .expiryDate!),
                                                        Rewardtype
                                                            .cashTransaction);
                                                    loyaltyManager.isOverlayOpen
                                                        .value = true;
                                                  },
                                                  child: YourRewardCard(
                                                    isOverlay: false,
                                                    rewardState: isActive(
                                                        _loyaltyManager
                                                            .recentRewardTransactionsList[
                                                                index]
                                                            .date!,
                                                        _loyaltyManager
                                                            .recentRewardTransactionsList[
                                                                index]
                                                            .expiryDate!),
                                                    rewardtype: _loyaltyManager
                                                                .recentRewardTransactionsList[
                                                                    index]
                                                                .typeId
                                                                .toString() ==
                                                            "referralBonnus"
                                                        ? Rewardtype
                                                            .referralBonus
                                                        : _loyaltyManager
                                                                    .recentRewardTransactionsList[
                                                                        index]
                                                                    .typeId
                                                                    .toString() ==
                                                                "cacheTransaction"
                                                            ? Rewardtype
                                                                .cashTransaction
                                                            : _loyaltyManager
                                                                        .recentRewardTransactionsList[
                                                                            index]
                                                                        .typeId
                                                                        .toString() ==
                                                                    "Recharge"
                                                                ? Rewardtype
                                                                    .recharge
                                                                : _loyaltyManager
                                                                            .recentRewardTransactionsList[
                                                                                index]
                                                                            .typeId
                                                                            .toString() ==
                                                                        "nonCacheTransaction"
                                                                    ? Rewardtype
                                                                        .recharge
                                                                    : Rewardtype
                                                                        .cashTransaction,
                                                    date: CommonMethods()
                                                        .getOnlyDate(
                                                            date: _loyaltyManager
                                                                .recentRewardTransactionsList[
                                                                    index]
                                                                .expiryDate),
                                                    points: _loyaltyManager
                                                        .recentRewardTransactionsList[
                                                            index]
                                                        .points!
                                                        .toInt(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                ),
                                const SizedBox(height: 10),
                                CommonBanner(
                                  margin: EdgeInsets.zero,
                                ),
                                const SizedBox(height: 10),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //"2023-01-20T10:19:28Z"
  // bool isActive(String dateTime) {
  RewardState isActive(String dateTime, String expireDate) {
    DateTime dateNow = DateTime.now();
    DateTime expireDateTemp =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse("2023-01-19T10:19:28Z");
    DateTime startDateTemp =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse("2022-01-20T10:19:28Z");

    final difference = dateNow.difference(startDateTemp);
    final expiredifference = dateNow.difference(expireDateTemp);
    print(difference.inHours.abs());
    print(startDateTemp);

    if (difference.inHours.abs() <= 12) {
      return RewardState.won;
    } else if (difference.inHours.abs() > 12) {
      return RewardState.used;
    } else if (expiredifference.inDays.abs() > 0) {
      return RewardState.expired;
    } else {
      return RewardState.used;
    }
  }
}

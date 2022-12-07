import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cashback_redeemption_screen.dart';
import 'package:india_one/screens/loyality_points/loyality_manager.dart';
import 'package:india_one/screens/loyality_points/redeem_points/rp_ui.dart';

import '../constant/theme_manager.dart';

class YourRewardCard extends StatefulWidget {
  YourRewardCard(
      {required this.rewardState,
      required this.rewardtype,
      required this.date,
      required this.points});
  final RewardState rewardState;
  final Rewardtype rewardtype;
  final String date;
  final int points;

  @override
  State<YourRewardCard> createState() => _YourRewardCardState();
}

class _YourRewardCardState extends State<YourRewardCard>
    with TickerProviderStateMixin {
  late OverlayEntry _overlayEntry;
  AnimationController? animationController;
  Animation<double>? animation;
  final loyaltyManager = Get.find<LoyaltyManager>();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        CurveTween(curve: Curves.decelerate).animate(animationController!);
  }

  void _showOverlay() async {
    OverlayState? _overlayState = Overlay.of(Get.context!);
    _overlayEntry = OverlayEntry(builder: (context) {
      return Material(
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
                      onPressed: () => animationController!
                          .reverse()
                          .then((_) => _closeOverlay()),
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
                    child: widget.rewardtype == RewardState.won
                        ? wonCard(true)
                        : usedBgCard(
                            context,
                            widget.rewardState,
                            widget.rewardtype,
                            widget.date,
                            widget.points,
                            true),
                  ),
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
                          Text(
                            'You just won',
                            style: TextStyle(
                                fontSize: 12.0.sp,
                                fontFamily: AppFonts.appFont,
                                color: Colors.black),
                          ),
                          Text(
                            '${widget.points} Points',
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
                          Text(
                            'Use by ${widget.date}',
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
                                Get.to(() => RedeemPointsPage());
                                // Get.snackbar('Hurray!!', 'Going to redeem page',
                                //     snackPosition: SnackPosition.BOTTOM);
                              } else {
                                _closeOverlay();
                                Get.snackbar('Oops!!',
                                    'You can redeem only if you have 15+ points',
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
                                    child: Text(
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
      );
    });
    animationController!.addListener(() {
      _overlayState!.setState(() {});
    });
    _overlayState!.insert(_overlayEntry);
    animationController!.forward();
  }

  void _closeOverlay() {
    _overlayEntry.remove();
  }

// ----------------------------------------  overlay end --------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.rewardState == RewardState.won

            // won  card container ---------------------------
            ? GestureDetector(
                onTap: () {
                  _showOverlay();
                },
                child: wonCard(false))
            :
            // used or expired card container ---------------------------------
            GestureDetector(
                onTap: () {
                  _showOverlay();
                },
                child: usedBgCard(context, widget.rewardState,
                    widget.rewardtype, widget.date, widget.points, false))
      ],
    );
  }

// wonCard -------------------------------------
  Widget wonCard(bool isOverlay) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.rewardWon), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(4.0.wp)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.0.wp, left: 4.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You just won!',
                      style: TextStyle(
                          fontSize: 10.0.sp,
                          fontFamily: AppFonts.appFont,
                          color: widget.rewardState == RewardState.won
                              ? Colors.white
                              : Colors.black),
                    ),
                    SizedBox(height: 1.0.wp),
                    Text(
                      '${widget.points} Points',
                      style: TextStyle(
                          fontFamily: AppFonts.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0.sp,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 4.0.wp, left: 4.0.wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getRewardType(widget.rewardtype, isOverlay),
                      SizedBox(height: 1.0.wp),
                      Text(
                        'Use by ${widget.date}',
                        style: TextStyle(
                            fontSize: 10.0.sp,
                            fontFamily: AppFonts.appFont,
                            color: Colors.white),
                      )
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }

// usedbgCard image string --------------------------
  String bgUsed(Rewardtype rewardtype, RewardState rewardState) {
    String usedBg;

    switch (rewardState) {
      case RewardState.expired:
        usedBg = AppImages.cardImageshadow;
        break;
      case RewardState.used:
        switch (rewardtype) {
          case Rewardtype.cashTransaction:
            usedBg = AppImages.referralBonusImage; // to change later
            break;
          case Rewardtype.referralBonus:
            usedBg = AppImages.referralBonusImage;
            break;
          case Rewardtype.recharge:
            usedBg = AppImages.referralBonusImage;
            break;
          case Rewardtype.loan:
            usedBg = AppImages.loanImage;
            break;
        }
        break;
      case RewardState.won:
        usedBg = '';
    }

    return usedBg;
  }

  // usedBgCard Container --------------------------------------
  Widget usedBgCard(BuildContext context, RewardState rewardState,
      Rewardtype rewardtype, String date, int points, bool isOverlay) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage(bgUsed(rewardtype)), fit: BoxFit.fill),
                  color: rewardState == RewardState.used
                      ? Colors.white
                      : const Color(0xfff0f0f0), //Colors.blue.withOpacity(0.5),
                  border:
                      Border.all(color: const Color(0xffe7e7e7), width: 1.0),
                  borderRadius: BorderRadius.circular(4.0.wp)),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: SizedBox(
                  width: 18.0.wp,
                  height: 30.0.wp,
                  //color: Colors.teal.withOpacity(0.5),
                  child: Image.asset(
                    bgUsed(rewardtype, rewardState),
                    fit: BoxFit.fill,
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6.0.wp, left: 4.0.wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rewardState == RewardState.won
                            ? 'You just won!'
                            : 'You won!',
                        style: TextStyle(
                            fontSize: isOverlay == true ? 20 : 10.0.sp,
                            fontFamily: AppFonts.appFont,
                            color: rewardState == RewardState.won
                                ? Colors.white
                                : Colors.black),
                      ),
                      SizedBox(height: 1.0.wp),
                      Text(
                        '$points Points',
                        style: TextStyle(
                            fontFamily: AppFonts.appFont,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                isOverlay == true ? Dimens.font_24sp : 14.0.sp,
                            color: rewardState == RewardState.expired
                                ? Colors.black
                                : AppColors.pointsColor),
                      ),
                    ],
                  ),
                ),
                //const Center(child: SizedBox()),
                Padding(
                    padding: EdgeInsets.only(bottom: 4.0.wp, left: 4.0.wp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getRewardType(rewardtype, isOverlay),
                        SizedBox(height: 1.0.wp),
                        isOverlay == true
                            ? SizedBox.shrink()
                            : Text(
                                rewardState == RewardState.won ||
                                        rewardState == RewardState.used
                                    ? 'Use by $date'
                                    : 'Expired on $date',
                                style: TextStyle(
                                    fontSize: 10.0.sp,
                                    fontFamily: AppFonts.appFont,
                                    color: rewardState == RewardState.won
                                        ? Colors.white
                                        : Colors.black),
                              )
                      ],
                    ))
              ],
            ),
          ],
        );
      },
    );
  }

// to get reward type of the card -----------------------------------
  Widget getRewardType(Rewardtype rewardtype, bool isOverlay) {
    Widget getType;

    switch (rewardtype) {
      case Rewardtype.cashTransaction:
        getType = getrewardtype('Cash transaction', isOverlay);
        break;
      case Rewardtype.referralBonus:
        getType = getrewardtype('Referral bonus', isOverlay);
        break;
      case Rewardtype.recharge:
        getType = getrewardtype('Recharge', isOverlay);
        break;
      case Rewardtype.loan:
        getType = getrewardtype('Loan', isOverlay);
    }
    return getType;
  }

  // cash transaction type ------------------------------------
  Widget getrewardtype(String rewardtype, bool isOverlay) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.rewardState == RewardState.won
              ? AppColors.backGrounddarkheader
              : widget.rewardState == RewardState.used
                  ? const Color(0xfff0f0f0)
                  : const Color(0xffdedede)),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        rewardtype,
        style: TextStyle(
            fontFamily: AppFonts.appFont,
            fontSize: isOverlay == true ? 20 : 10.0.sp,
            color: widget.rewardState == RewardState.won
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}
// enum or constant value ---------------

enum RewardState { won, used, expired }

enum Rewardtype { referralBonus, cashTransaction, recharge, loan }

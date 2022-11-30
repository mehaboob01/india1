import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../constant/theme_manager.dart';

class YourRewardCard extends StatelessWidget {
  const YourRewardCard(
      {
      required this.rewardState,
      required this.rewardtype,
      required this.date,
      required this.points});
  final RewardState rewardState;
  final Rewardtype rewardtype;
  final String date;
  final int points;

  Widget containerOverLay() {
    return AlertDialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0.wp)),
      titlePadding: EdgeInsets.zero,
      title: SizedBox(
        width: 150,
        height: 250,
        child: wonCard(),
      ),
    );
  }

  BottomSheet bottomSheet() {
    return BottomSheet(
        enableDrag: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0.wp),
                topRight: Radius.circular(5.0.wp))),
        onClosing: () {},
        builder: (context) {
          return Container(
              padding: EdgeInsets.only(
                  left: 6.0.wp, top: 6.0.wp, right: 6.0.wp, bottom: 4.0.wp),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'You just won',
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        fontFamily: AppFonts.appFont,
                        color: Colors.black),
                  ),
                  Text(
                    '$points Points',
                    style: TextStyle(
                        fontFamily: AppFonts.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0.sp,
                        color: AppColors.pointsColor),
                  ),
                  SizedBox(height: 1.0.wp),
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
                    'Use by $date',
                    style: TextStyle(
                        fontSize: 12.0.sp,
                        fontFamily: AppFonts.appFont,
                        color: Colors.black),
                  ),
                  SizedBox(height: 1.0.wp),
                  GestureDetector(
                    onTap: () {
                      if (points > 15) {
                        Get.snackbar('Hurray!!', 'Going to redeem page',
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.snackbar('Oops!!',
                            'You can redeem only if you have 15+ points',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                      //Get.to(RedeemPointsPage());
                    },
                    child: Container(
                      height: 12.0.wp,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment(-2, 0),
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.orangeGradient1,
                                AppColors.orangeGradient2,
                              ]),
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
                          Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                AppImages.bgflower,
                                color: Colors.white,
                                fit: BoxFit.fill,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        rewardState == RewardState.won

            // won  card container ---------------------------
            ? GestureDetector(
                onTap: () {
                  //Get.showOverlay(asyncFunction: containerOverLay);
                  Get.dialog(containerOverLay());
                  Get.bottomSheet(bottomSheet());
                },
                child: wonCard())
            :
            // used or expired card container ---------------------------------
            usedBgCard(context, rewardState, rewardtype, date, points)
      ],
    );
  }

// wonCard -------------------------------------

  Widget wonCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              image:  DecorationImage(
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
                      getRewardType(rewardtype),
                      SizedBox(height: 1.0.wp),
                      Text(
                        'Use by $date',
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
      Rewardtype rewardtype, String date, int points) {
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
                            fontSize: 10.0.sp,
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
                            fontSize: 14.0.sp,
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
                        getRewardType(rewardtype),
                        SizedBox(height: 1.0.wp),
                        Text(
                          rewardState == RewardState.won ||  rewardState == RewardState.used
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
  Widget getRewardType(Rewardtype rewardtype) {
    Widget getType;

    switch (rewardtype) {
      case Rewardtype.cashTransaction:
        getType = cashTransactionType();
        break;
      case Rewardtype.referralBonus:
        getType = referralBounsType();
        break;
      case Rewardtype.recharge:
        getType = rechargeType();
        break;
      case Rewardtype.loan:
        getType = loanType();
    }
    return getType;
  }

  // cash transaction type ------------------------------------
  Widget cashTransactionType() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: rewardState == RewardState.won
              ? AppColors.backGrounddarkheader
              : rewardState == RewardState.used
                  ? const Color(0xfff0f0f0)
                  : const Color(0xffdedede)),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Cash transaction',
        style: TextStyle(
            fontFamily: AppFonts.appFont,
            fontSize: 10.0.sp,
            color:
                rewardState == RewardState.won ? Colors.white : Colors.black),
      ),
    );
  }

  //Referral bonus type ----------------------------------------
  Widget referralBounsType() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: rewardState == RewardState.won
              ? AppColors.backGrounddarkheader
              : rewardState == RewardState.used
                  ? const Color(0xfff0f0f0)
                  : const Color(0xffdedede)),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Referral bonus',
        style: TextStyle(
            fontFamily: AppFonts.appFont,
            fontSize: 10.0.sp,
            color:
                rewardState == RewardState.won ? Colors.white : Colors.black),
      ),
    );
  }

  //Recharge type ----------------------------------------
  Widget rechargeType() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: rewardState == RewardState.won
              ? AppColors.backGrounddarkheader
              : rewardState == RewardState.used
                  ? const Color(0xfff0f0f0)
                  : const Color(0xffdedede)),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Recharge',
        style: TextStyle(
            fontFamily: AppFonts.appFont,
            fontSize: 10.0.sp,
            color:
                rewardState == RewardState.won ? Colors.white : Colors.black),
      ),
    );
  }

  //loan type ----------------------------
  Widget loanType() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: rewardState == RewardState.won
              ? AppColors.backGrounddarkheader
              : rewardState == RewardState.used
                  ? const Color(0xfff0f0f0)
                  : const Color(0xffdedede)),
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'Loan',
        style: TextStyle(
            fontFamily: AppFonts.appFont,
            fontSize: 10.0.sp,
            color:
                rewardState == RewardState.won ? Colors.white : Colors.black),
      ),
    );
  }
}

// enum or constant value ---------------

enum RewardState { won, used, expired }

enum Rewardtype { referralBonus, cashTransaction, recharge, loan }

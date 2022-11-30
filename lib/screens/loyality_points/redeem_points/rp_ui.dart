import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cashback_redeemption_screen.dart';
import 'package:india_one/screens/loyality_points/redeem_points/rp_manager.dart';

import '../../../constant/theme_manager.dart';
import '../../../widgets/button_with_flower.dart';
import '../../../widgets/circular_progressbar.dart';
import '../../../widgets/common_redeem_card.dart';
import '../../../widgets/common_toggle_card.dart';
import '../../../widgets/loyalty_common_header.dart';
import '../cashback_redeem/cb_manager.dart';
import '../loyality_manager.dart';

class RedeemPointsPage extends StatelessWidget {

  final cashbackManager = Get.put(CashBackManager());
  RedeemPointsPage();
  final homeCtrl = Get.put(CashBackController());
  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());

  final List<bool> isSelectedRedeemType = [false, false].obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Obx(
            () => _loyaltyManager.isLoading.value == true
                ? CircularProgressbar()
                : SafeArea(
                    child: Column(children: [
                    CustomAppBar(heading: 'Redeem points'),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Padding(
                                padding: EdgeInsets.all(4.0.wp),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // heading card section
                                      Container(
                                        width: double.maxFinite,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 4.0.wp),
                                        height: 26.0.wp,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.0.wp),
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  AppColors.backGroundgradient1,
                                                  AppColors.backGroundgradient2
                                                ])),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(4.0.wp),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Redeem your balance',
                                                    style: AppStyle.shortHeading
                                                        .copyWith(
                                                      fontSize: 12.0.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.0.wp),
                                                  Row(
                                                    textBaseline:
                                                        TextBaseline.alphabetic,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                          AppImages.coins),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                          _loyaltyManager
                                                              .redeemablePoints
                                                              .toString(),
                                                          style: AppStyle
                                                              .shortHeading
                                                              .copyWith(
                                                                  fontSize:
                                                                      18.0.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.5),
                                                        ),
                                                      ),
                                                      Text(
                                                        ' Points',
                                                        style: AppStyle
                                                            .shortHeading
                                                            .copyWith(
                                                          fontSize: 14.0.sp,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Image.asset(
                                                  AppImages.flower2,
                                                  fit: BoxFit.fill,
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 2.0.wp),
                                      Text(
                                        'You can redeem your points either through recharge or cashback to your bank account or UPI.',
                                        style: AppStyle.shortHeading.copyWith(
                                          fontSize: 12.0.sp,
                                          height: 1.2.sp,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4.0.wp),
                                      Obx(() {
                                        return CommonToggleCard(

                                          isSelectedlist: isSelectedRedeemType,
                                          redeemCardList: [
                                            RedeemCard(
                                              imageSvg:
                                                  AppImages.mobilRechargeSvg,
                                              label: 'Mobile recharge',
                                              isSelected:
                                                  isSelectedRedeemType[0],
                                            ),
                                            RedeemCard(
                                              imagePng: AppImages.walletIcon,
                                              label: 'Cashback',
                                              isSelected:
                                                  isSelectedRedeemType[1],
                                            )
                                          ],
                                        );
                                      })
                                    ])))),
                    // bottom button

                    Padding(
                      padding: EdgeInsets.all(6.0.wp),
                      child: Obx(() {
                        return ButtonWithFlower(
                          onPressed: isSelectedRedeemType
                              .any((element) => element == true)?() {
                            bool redeemIndex =
                                isSelectedRedeemType.any((element) => element);
                            RedeemType redeemType;
                            if (redeemIndex == false) {
                              Get.snackbar(
                                  'Oops!!', 'Select a way to redeem points');
                            }
                            if (isSelectedRedeemType.indexOf(redeemIndex) ==
                                0) {
                              redeemType = RedeemType.isMobileRecharge;
                            } else {
                              redeemType = RedeemType.isCashback;
                            }
                            goToScreen(redeemType: redeemType);
                            print(
                                '$redeemType, ${isSelectedRedeemType.indexOf(redeemIndex)}');
                          }: ()=> null,
                          label: 'Proceed',
                          buttonWidth: double.maxFinite,
                          buttonHeight: 12.0.wp,
                          labelSize: 14.0.sp,
                          labelColor: Colors.white,
                          labelWeight: FontWeight.bold,
                          iconToRight: isSelectedRedeemType
                                  .any((element) => element == true)
                              ? true
                              : false,
                          iconColor: Colors.white,
                          buttonColor: isSelectedRedeemType
                                  .any((element) => element == true)
                              ? null
                              : const Color(0xffc1c1c1),
                          buttonGradient: isSelectedRedeemType
                                  .any((element) => element == true)
                              ? const LinearGradient(
                                  begin: Alignment(-2, 0),
                                  end: Alignment.centerRight,
                                  colors: [
                                      AppColors.orangeGradient1,
                                      AppColors.orangeGradient2,
                                    ])
                              : null,
                        );
                      }),
                    )
                  ])),
          )),
    );
  }

  void goToScreen({required RedeemType redeemType}) {
    switch (redeemType) {
      // TODO  add mobile recharge route here
      case RedeemType.isMobileRecharge:
        Get.toNamed(MRouter.mobileRechargeIO);
        break;
      case RedeemType.isCashback:



        // todo


      cashbackManager.callBankListApi();


        Navigator.push(
            Get.context!,
            MaterialPageRoute(
                builder: (BuildContext context) => CashBackRedeemPage()));

        break;
    }
  }
}

enum RedeemType { isMobileRecharge, isCashback }

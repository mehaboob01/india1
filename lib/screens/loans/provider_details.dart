import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'model/loan_lender_others_model.dart';

class ProviderDetail extends StatelessWidget {
  final String title;
  final Lenderss lenders;
  final bool personalLoan;
  final String providerId;

  ProviderDetail({
    Key? key,
    required this.title,
    required this.lenders,
    required this.personalLoan,
    required this.providerId,
  }) : super(key: key);

  LoanController loanController = Get.put(LoanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                CustomAppBar(
                  heading: '$title',
                  customActionIconsList: [
                    // CustomActionIcons(
                    //   image: AppImages.bottomNavHome,
                    // ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.loyaltyCardBg),
                          fit: BoxFit.fill)
                      // gradient: LinearGradient(
                      //   begin: Alignment(-2, 0),
                      //   end: Alignment.centerRight,
                      //   colors: [
                      //     AppColors.selectedLangColor,
                      //     AppColors.backGroundgradient2,
                      //   ],
                      // ),
                      ),
                  padding: EdgeInsets.all(12),
                  child: LoanCommon().loanCard(
                    lenders: lenders,
                    isPersonalLoan: personalLoan,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top Features",
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: Dimens.font_20sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          if (lenders.keywords != null ||
                              lenders.keywords != [])
                            ListView.builder(
                              itemCount: lenders.keywords!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return LoanCommon().bulletPoint(
                                  title: "${lenders.keywords?[index] ?? ''}",
                                );
                              },
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Other details",
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: Dimens.font_20sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            itemCount: loanController.otherDetails.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                title: Text(
                                  '${loanController.otherDetails[index]['title']}',
                                ),
                                children: [
                                  Text(
                                    '${loanController.otherDetails[index]['value']}',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: InkWell(
                onTap: () {
                  LoanCommon().bottomSheet(
                    context,
                    lenderId: lenders.id ?? '',
                    callBack: () {
                      Get.back();
                      loanController.applyLoan(
                        providerId: providerId ?? '',
                        lenderId: lenders.id ?? '',
                      );
                    },
                    providerId: '',
                  );
                },
                child: LoanCommon().customButton(
                  title: 'Apply now',
                ),
              ),
            ),
            if (loanController.createLoanLoading.value == true)
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: LoadingAnimationWidget.inkDrop(
                  size: 34,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/screens/loans/model/loan_providers_model.dart';

import '../../utils/common_methods.dart';
import 'model/loan_lender_others_model.dart';

enum LoanType {
  PersonalLoan,
  GoldLoan,
  BikeLoan,
  CarLoan,
  TractorLoan,
  FarmLoan
}

class LoanCommon {
  Widget backButton({context}) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.9,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Back',
            style: AppTextThemes.button,
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          end: Alignment.topRight,
          colors: [Color(0xFF357CBE), Color(0xFF004280)],
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }

  Widget nextButton() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: AppTextThemes.button,
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            end: Alignment.topRight,
            colors: [Colors.orange, Colors.redAccent],
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }

  Widget customButton({required String title}) {
    return Container(
      width: double.maxFinite,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Row(
            children: [
              Text(
                '$title',
                style: AppTextThemes.button,
              ),
              SizedBox(
                width: 6,
              ),
            ],
          ),
          Spacer(),
          // SizedBox(
          //   height: 48,
          //   child: Image.asset(
          //     "assets/images/btn_img.png",
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          end: Alignment.topRight,
          colors: [Colors.orange, Colors.redAccent],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: Offset(
              -6.0,
              -6.0,
            ),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: AppColors.darkerGrey.withOpacity(0.4),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        // color: termConditionChecked == true
        //     ? AppColors.btnColor
        //     : AppColors.btnDisableColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
  }

  Widget loanCard({
    Function? applyButtonClick,
    bool? isPersonalLoan,
    Providers? providers,
    // Lenders? lenders,
    Lenderss? lenders
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          imageUrl: (isPersonalLoan == true
                                  ? (providers?.logoURL ?? '')
                                  : lenders?.logoURL) ??
                              '',
                          errorWidget: (context, _, error) {
                            return Icon(
                              Icons.warning_amber_outlined,
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (isPersonalLoan == true
                                    ? (providers?.name ?? '')
                                    : lenders?.loanTitle.toString()) ??
                                "Bajaj Finance",
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: Dimens.font_16sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            (isPersonalLoan == true
                                    ? providers?.subTitle
                                    : (lenders?.loanType ?? '')) ??
                                "Easy loan processing",
                            style: TextStyle(
                              color: AppColors.borderColor,
                              fontSize: Dimens.font_14sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              if (applyButtonClick == null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    rowText(
                      value: 'Max amount',
                      title:
                          '₹ ${CommonMethods().indianRupeeValue(double.parse(lenders!.loanMaxAmount!.toString()) ?? 0)}'),
                    rowText(
                      value: 'Tenure',
                      title: '${lenders.minTenureInMonths} - ${lenders.maxTenureInMonths}months  ',
                    ),
                    rowText(
                      value: 'Interest/m',
                      title:
                          '${lenders.minInterestRate} - ${lenders.maxInterestRate}%',
                    ),
                  ],
                ),
              ] else ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: InkWell(
                    onTap: () {
                      applyButtonClick();
                    },
                    child: LoanCommon().customButton(
                      title: isPersonalLoan == true ? 'Explore' : 'Apply now',
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget rowText({required String title, required String value}) {
    return Column(
      children: [
        Container(
          width: 98,
          child: Text(
            "$title",
            style: TextStyle(
              color: AppColors.iconColorDark,
              fontSize: Dimens.font_12sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          "$value",
          style: TextStyle(
            color: AppColors.iconColorDark,
            fontSize: Dimens.font_12sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget bulletPoint({
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: AppColors.checkBoxColor,
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            "$title",
            style: TextStyle(
              color: AppColors.lightBlack,
              fontSize: Dimens.font_16sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  bottomSheet(context,
      {required String lenderId,
      required String providerId,
      required Function callBack}) {



    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (context) {



        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 8,
                width: 50,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: AppColors.dotsColor,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 30,
                    color: AppColors.lightBlack,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Do you want to proceed?",
                  style: TextStyle(
                    color: AppColors.lightBlack,
                    fontSize: Dimens.font_22sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please verify all the details provided. Once it is submitted, you will not be allowed to change the details.",
                  style: TextStyle(
                    color: AppColors.lightBlack,
                    fontSize: Dimens.font_16sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                  onTap: () {
                    callBack();
                  },
                  child: LoanCommon().customButton(title: 'Apply for loan')),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget filledButton({required String title, Function? callBack}) {
    return InkWell(
      onTap: () {
        callBack!();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: Text(
          '$title',
          style: AppTextThemes.button,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            end: Alignment.topRight,
            colors: [Colors.orange, Colors.redAccent],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: Offset(
                -6.0,
                -6.0,
              ),
              blurRadius: 16.0,
            ),
            BoxShadow(
              color: AppColors.darkerGrey.withOpacity(0.4),
              offset: Offset(6.0, 6.0),
              blurRadius: 16.0,
            ),
          ],
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }

  Widget borderButton({required String title, Function? callBack}) {
    return InkWell(
      onTap: () {
        callBack!();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: Text(
          '$title',
          style: TextStyle(
            fontSize: Dimens.font_16sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Graphik',
            color: AppColors.blueColor,
          ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blueColor,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}

extension on int {
  String get priceString {
    final numberString = toString();
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, ',');
      index -= 3;
    }
    return numberDigits.join();
  }
}

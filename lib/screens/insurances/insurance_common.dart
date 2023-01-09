import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/theme_manager.dart';
import '../loans/loan_common.dart';

enum InsuranceType {
  CriticalIllness,
  Accidental,
}

class InsuranceCommon {
  bottomSheet(context, {required Function callBack}) {
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
                child: text(
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
                child: text(
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
                  child: LoanCommon().customButton(title: 'Proceed to pay')),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}

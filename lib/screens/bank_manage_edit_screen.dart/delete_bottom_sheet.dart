import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/button_with_flower.dart';

class CommonDeleteBottomSheet {
  Future deleteBottomSheet(
      {required int index, required VoidCallback onDelete}) async {
    double height = Get.height * 0.3;
    return Get.bottomSheet(Container(
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0.wp),
              topRight: Radius.circular(5.0.wp))),
      child: Stack(
        children: [
          Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  size: 25,
                  color: AppColors.blackColor,
                ),
                onPressed: () => Get.back(),
              )),
          Padding(
            padding: EdgeInsets.only(
                top: 6.0.hp, left: 6.0.wp, right: 6.0.wp, bottom: 2.0.hp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do you want to delete account?',
                  style: AppStyle.shortHeading.copyWith(
                      color: const Color(0xff2d2d2d),
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  'Once you delete the account details, it cannot be used to redeem the points. This cannot be reversed.',
                  style: AppStyle.shortHeading.copyWith(
                    color: const Color(0xff2d2d2d),
                    height: 1.5,
                    fontSize: 12.0.sp,
                  ),
                ),
                const Spacer(),
                ButtonWithFlower(
                  label: 'Delete account details',
                  onPressed: onDelete,
                  buttonWidth: double.maxFinite,
                  buttonHeight: height * 0.2,
                  labelSize: 14.0.sp,
                  labelColor: Colors.white,
                  labelWeight: FontWeight.w600,
                  iconToRight: true,
                  iconColor: Colors.white,
                  buttonGradient: const LinearGradient(
                      begin: Alignment(-2, 0),
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.orangeGradient1,
                        AppColors.orangeGradient2,
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }

  Future deleteBottomSheet2({required VoidCallback onDelete}) async {
    double height = Get.height * 0.3;
    return Get.bottomSheet(Container(
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0.wp),
              topRight: Radius.circular(5.0.wp))),
      child: Stack(
        children: [
          Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  size: 25,
                  color: AppColors.blackColor,
                ),
                onPressed: () => Get.back(),
              )),
          Padding(
            padding: EdgeInsets.only(
                top: 6.0.hp, left: 6.0.wp, right: 6.0.wp, bottom: 2.0.hp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do you want to delete account?',
                  style: AppStyle.shortHeading.copyWith(
                      color: const Color(0xff2d2d2d),
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  'Once you delete the account details, it cannot be used to redeem the points. This cannot be reversed.',
                  style: AppStyle.shortHeading.copyWith(
                    color: const Color(0xff2d2d2d),
                    height: 1.5,
                    fontSize: 12.0.sp,
                  ),
                ),
                const Spacer(),
                ButtonWithFlower(
                  label: 'Delete account details',
                  onPressed: onDelete,
                  buttonWidth: double.maxFinite,
                  buttonHeight: height * 0.2,
                  labelSize: 14.0.sp,
                  labelColor: Colors.white,
                  labelWeight: FontWeight.w600,
                  iconToRight: true,
                  iconColor: Colors.white,
                  buttonGradient: const LinearGradient(
                      begin: Alignment(-2, 0),
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.orangeGradient1,
                        AppColors.orangeGradient2,
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

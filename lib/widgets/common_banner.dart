import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';

class CommonBanner extends StatelessWidget {
 // const CommonBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.maxFinite,
        height: 32.0.wp,
        margin: EdgeInsets.symmetric(horizontal: 2.0.hp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0.wp),
            gradient:  LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.referEarnGradient1,
                  AppColors.referEarnGradient2
                ])),
        // image: const DecorationImage(
        //     image: AssetImage(AppImages.atmBg2), fit: BoxFit.fill)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // text
            Flexible(
              flex: 4,
              child: Padding(
                padding:
                EdgeInsets.only(top: 6.0.wp, bottom: 6.0.wp, left: 4.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: AppStyle.shortHeading.copyWith(
                                color: Colors.white,
                                //fontWeight: FontWeight.w600,
                                fontSize: 8.0.sp,
                                height: 1.5),
                            text:
                            'Refer a friend or a family member & get\na chance to',
                            children: [
                              TextSpan(
                                  text: ' Earn upto 100 points',
                                  style: AppStyle.shortHeading.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600)),
                            ])),
                    // SizedBox(height: 1.0.wp),
                    SizedBox(height: 5.0.wp),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Refer Now',
                            style: AppStyle.shortHeading.copyWith(
                                color: AppColors.yellowgradient1,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.sp)),
                        SizedBox(width: 2.0.wp),
                        Image.asset(AppImages.rightArrow)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Right Image
            Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 2.0.wp, bottom: 2.0.wp, left: 2.0.wp, right: 2.0.wp),
                  //color: Colors.red,
                  child: Center(
                      child: Image.asset(
                        AppImages.referEarnSVG,
                        fit: BoxFit.fill,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
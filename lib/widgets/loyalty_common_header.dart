import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';


// Appbar section --------------------------------
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.heading,
  }) : super(key: key);
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0.wp,
      width: double.infinity,
      //padding: EdgeInsets.only(top: 8.0.wp, left: 2.0.wp),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              size: 10.0.wp,
              color: Colors.black,
            ),
          ),
          Text(
            heading,
            style: AppStyle.shortHeading.copyWith(
                color: const Color(0xff2d2d2d), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// Loyalty common heading screen
class HeadingContainer extends StatelessWidget {
  const HeadingContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(vertical: 4.0.wp),
        height: 44.0.wp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0.wp),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.backGroundgradient1,
                  AppColors.backGroundgradient2
                ])),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.0.wp, left: 4.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current balance',
                    style: AppStyle.shortHeading.copyWith(
                      fontSize: 12.0.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.0.wp),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Image.asset(AppImages.coins),
                      Text(
                        ' 52',
                        style: AppStyle.shortHeading.copyWith(
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                      Text(
                        ' Points',
                        style: AppStyle.shortHeading.copyWith(
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
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 14.0.wp,
                margin: EdgeInsets.only(
                    left: 4.0.wp, right: 4.0.wp, bottom: 6.0.wp),
                padding:
                    EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0.wp),
                    color: AppColors.backGrounddarkheader),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // total earned row
                      Row(children: [
                        Text(
                          'Total earned : ',
                          style: AppStyle.shortHeading.copyWith(
                            fontSize: 11.0.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '71',
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5),
                        ),
                      ]),
                      // total redeemed row
                      Row(
                        children: [
                          Text(
                            'Total redeemed : ',
                            style: AppStyle.shortHeading.copyWith(
                              fontSize: 11.0.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '16',
                            style: AppStyle.shortHeading.copyWith(
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            Positioned(
                width: 200,
                top: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 1.0.wp),
                  child: Image.asset(
                    AppImages.celebrationBg,
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
              top: 32,
              right: 18,
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 10.0.wp,
                    width: 40.0.wp,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.0.wp)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Redeem Now',
                            style: AppStyle.shortHeading.copyWith(
                                fontSize: 10.0.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.butngradient1,
                                letterSpacing: 0.5),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              AppImages.bgflower,
                              fit: BoxFit.fill,
                            ))
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/theme_manager.dart';
import '../core/data/local/shared_preference_keys.dart';
import '../screens/loyality_points/loyality_manager.dart';
import '../screens/loyality_points/redeem_points/rp_ui.dart';
import 'button_with_flower.dart';

// Appbar section --------------------------------
class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      required this.heading,
      this.customActionIconsList,
      this.actionIcons,
      this.hasLogo = false,
      this.haveHomeIcons = false,
      this.bgColor})
      : super(key: key);
  final String heading;
  final List<CustomActionIcons>? customActionIconsList;
  final bool? hasLogo;
  final List<Widget>? actionIcons;
  final bool? haveHomeIcons;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      child: Container(
        height: 20.0.wp,
        width: double.infinity,
        //padding: EdgeInsets.only(top: 8.0.wp, left: 2.0.wp),
        color: bgColor ?? Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hasLogo == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: 50,
                      height: double.maxFinite,
                      // color: Colors.red,
                      child: SvgPicture.asset(AppImages.newIndiaOneSvg),
                    ))
                : GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 10.0.wp,
                      color: Colors.black,
                    ),
                  ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  heading,
                  style: AppStyle.shortHeading.copyWith(
                      color: const Color(0xff2d2d2d),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: haveHomeIcons == true
                  ? Row(
                      children: actionIcons ?? [],
                    )
                  : Row(children: customActionIconsList ?? []),
            )
          ],
        ),
      ),
    );
  }
}

class CustomActionIcons extends StatelessWidget {
  const CustomActionIcons(
      {Key? key,
      this.customGradientColors,
      required this.image,
      this.isSvg = true,
      this.beginsAt = Alignment.topLeft,
      this.endsAt = Alignment.bottomRight,
      this.stops = const [0.5, 1.0],
      this.imageColor,
      required this.onHeaderIconPressed})
      : super(key: key);

  final List<Color>? customGradientColors;
  final bool? isSvg;
  final String image;
  final Color? imageColor;
  final List<double>? stops;
  final Alignment? beginsAt;
  final Alignment? endsAt;
  final Future Function() onHeaderIconPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: SizedBox(
        width: 6.0.wp,
        height: 6.0.wp,
        child: customGradientColors != null
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs!.setBool(SPKeys.SHOW_AUTH, false);
                  onHeaderIconPressed();
                },
                child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                              begin: beginsAt!,
                              end: endsAt!,
                              stops: stops,
                              colors: List.generate(
                                  customGradientColors!.length,
                                  (index) => customGradientColors![index]))
                          .createShader(bounds);
                    },
                    child: SvgPicture.asset(image, fit: BoxFit.fill)),
              )
            : isSvg!
                ? GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs!.setBool(SPKeys.SHOW_AUTH, false);
                      onHeaderIconPressed();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: SvgPicture.asset(
                      image,
                      color: imageColor,
                      fit: BoxFit.fill,
                    ),
                  )
                : Image.asset(image, color: imageColor, fit: BoxFit.fill),
      ),
    );
  }
}

// Loyalty common heading screen
class HeadingContainer extends StatelessWidget {
  LoyaltyManager _loyaltyManager = Get.find();

  HeadingContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(vertical: 4.0.wp),
        height: 50.0.wp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0.wp),
            image: DecorationImage(
                image: AssetImage(AppImages.loyaltyCardBg), fit: BoxFit.cover)
            // gradient: const RadialGradient(
            //     radius: 1.3, focal: Alignment.center, focalRadius: 0.2,
            //     // begin: Alignment.centerLeft,
            //     // end: Alignment.centerRight,
            //     colors: [AppColors.blueColor, Color(0xffED1C24)])
            // gradient: const LinearGradient(
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight,
            //     colors: [
            //       AppColors.backGroundgradient1,
            //       AppColors.backGroundgradient2
            //     ])
            ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0.wp, left: 4.0.wp),
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
                      SizedBox(
                        width: 4,
                      ),
                      Obx(
                        () => Text(
                          _loyaltyManager.redeemablePoints.toString(),
                          style: AppStyle.shortHeading.copyWith(
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5),
                        ),
                      ),
                      Text(
                        ' Points',
                        style: AppStyle.shortHeading.copyWith(
                          fontSize: 14.0.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 14,
                  // ),
                  // Obx(
                  //   () => Visibility(
                  //     visible:
                  //         _loyaltyManager.redeemablePoints <= 14 ? true : false,
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 4.0),
                  //       child: Text(
                  //         'Note : You can redeem only if you have 15 points',
                  //         style: AppStyle.shortHeading.copyWith(
                  //           fontSize: Dimens.font_12sp,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                            fontSize: 12.0.sp,
                            color: Colors.white,
                          ),
                        ),
                        Obx(
                          () => Text(
                            _loyaltyManager.pointsEarned.toString(),
                            style: AppStyle.shortHeading.copyWith(
                                fontSize: Dimens.font_12sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5),
                          ),
                        ),
                      ]),
                      // total redeemed row
                      Row(
                        children: [
                          Text(
                            'Total redeemed : ',
                            style: AppStyle.shortHeading.copyWith(
                              fontSize: 12.0.sp,
                              color: Colors.white,
                            ),
                          ),
                          Obx(
                            () => Text(
                              _loyaltyManager.pointsRedeemed.toString(),
                              style: AppStyle.shortHeading.copyWith(
                                  fontSize: Dimens.font_12sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            Positioned(
                width: 200,
                top: 0,
                right: 2,
                child: Container(
                  height: 125,
                  //color: Colors.tealAccent,
                  child: Padding(
                    padding: EdgeInsets.only(right: 1.0.wp),
                    child: Image.asset(
                      AppImages.celebrationBg,
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
            Obx(
              () => Positioned(
                top: 32,
                right: 18,
                child: ButtonWithFlower(
                  buttonColor: Colors.white,
                  onPressed: () {
                    _loyaltyManager.redeemablePoints >= 14
                        ? Get.to(() => RedeemPointsPage())
                        : Get.snackbar('Oops!!',
                            'You can redeem only if you have 15 or more points',
                            snackPosition: SnackPosition.BOTTOM);
                    // : Get.toNamed(MRouter.map);
                  },
                  buttonHeight: 12.0.wp,
                  buttonWidth: 44.0.wp,
                  label: _loyaltyManager.redeemablePoints >= 14
                      ? 'Redeem Now'
                      : 'Earn more points',
                  labelSize: 12.0.sp,
                  labelWeight: FontWeight.w600,
                  labelColor: AppColors.blueColor,
                ),
              ),
            )
          ],
        ));
  }
}

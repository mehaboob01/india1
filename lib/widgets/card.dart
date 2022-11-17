import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:india_one/constant/theme_manager.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.image,
    required this.label,
    required this.itembgColor,
  });
  final String image;
  final String label;

  final ItemCardbgColor itembgColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      type: MaterialType.transparency,
      child: Container(
        width: 26.0.wp,
        height: 26.0.wp,
        margin: EdgeInsets.all(1.0.wp),
        padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 2.0.wp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.wp),
            gradient: itembg(itembgColor)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Column(
                children: [
                  ShaderMask(
                      shaderCallback: (bounds) {
                        return itemIconbg(itembgColor).createShader(bounds);
                      },
                      child: SvgPicture.asset(image)),
                  SizedBox(height: 2.0.wp),
                  Image.asset(AppImages.cardImageshadow),
                  SizedBox(height: 1.0.wp),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                label,
                style: AppStyle.shortHeading.copyWith(
                    color: AppColors.black,
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.w400),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient itemIconbg(ItemCardbgColor bgtype) {
    LinearGradient itemCardbgColor;
    switch (bgtype) {
      case ItemCardbgColor.lightBlue:
        itemCardbgColor = LinearGradient(
            //transform: matrix(1, 0, 0, -1, 0, 0);
            transform: GradientRotation(120.0),
            stops: [
              0.0,
              0.5
            ],
            colors: [
              AppColors.blueIconGradient1,
              AppColors.backGroundgradient2
            ]);
        break;
      case ItemCardbgColor.skyBlue:
        itemCardbgColor = const LinearGradient(
            transform: GradientRotation(120.0),
            // stops: [
            //   0.0,
            //   0.5
            // ],
            colors: [
              AppColors.violetIconGradient1,
              AppColors.violetIconGradient2
            ]);
        break;
      case ItemCardbgColor.lightRed:
        itemCardbgColor = const LinearGradient(
            transform: GradientRotation(120.0),
            stops: [0.0, 0.5],
            colors: [AppColors.redIconGradient1, AppColors.redIconGradient2]);
        break;
      case ItemCardbgColor.lightRed2:
        itemCardbgColor = const LinearGradient(
            transform: GradientRotation(120.0),
            // stops: [
            //   0.0,
            //   0.5
            // ],
            colors: [
              AppColors.yellowIconGradient1,
              AppColors.yellowIconGradient2
            ]);
        break;
    }
    return itemCardbgColor;
  }

  LinearGradient itembg(ItemCardbgColor bgtype) {
    LinearGradient itemCardbgColor;
    switch (bgtype) {
      case ItemCardbgColor.lightBlue:
        itemCardbgColor = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardGradientblue1,
              AppColors.cardGradientcommon2
            ]);
        break;
      case ItemCardbgColor.skyBlue:
        itemCardbgColor = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardGradientskyBlue,
              AppColors.cardGradientcommon2
            ]);
        break;
      case ItemCardbgColor.lightRed:
        itemCardbgColor = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardGradientred1,
              AppColors.cardGradientcommon2
            ]);
        break;
      case ItemCardbgColor.lightRed2:
        itemCardbgColor = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cardGradientred2,
              AppColors.cardGradientcommon2
            ]);
        break;
    }
    return itemCardbgColor;
  }
}

enum ItemCardbgColor { lightBlue, skyBlue, lightRed2, lightRed }

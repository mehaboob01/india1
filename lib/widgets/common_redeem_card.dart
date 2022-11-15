import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';


class RedeemCard extends StatelessWidget {
  const RedeemCard(
      {
      required this.isSelected,
      this.imagePng,
      this.imageSvg,
      required this.label});
  final bool isSelected;
  final String? imagePng;
  final String? imageSvg;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.wp),
      child: Stack(
        children: [
          Container(
              width: 42.0.wp,
              height: 30.0.wp,
              padding:
                  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 4.0.wp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0.wp),
                  gradient: isSelected
                      ?  LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                              AppColors.backGroundgradient1,
                              AppColors.backGroundgradient2
                            ])
                      :  LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          transform: GradientRotation(4.63),
                          colors: [
                            // AppColors.cardGradientcommon2,
                            AppColors.cardGradientwhite1,
                            AppColors.cardGradientcommon2,
                          ],
                        )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 10.0.wp,
                      height: 10.0.wp,
                      //color: Colors.red,
                      child: imageSvg != null
                          ? SvgPicture.asset(
                              imageSvg!,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.backGroundgradient1,
                            )
                          : SvgPicture.asset(
                              imagePng!,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.backGroundgradient1,
                            )),
                  SizedBox(
                    width: 15.0.wp,
                    height: 4.0.wp,
                    //color: Colors.blue,
                    child: Image.asset(
                      AppImages.cardImageshadow,
                      fit: BoxFit.fill,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                  Text(
                    label,
                    style: AppStyle.shortHeading.copyWith(
                      fontSize: 12.0.sp,
                      height: 1.2.sp,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  )
                ],
              )),
          isSelected
              ? Positioned(
                  top: 2.0.wp,
                  right: 2.0.wp,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

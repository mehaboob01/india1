import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';


import '../constant/theme_manager.dart';

class ItemCard extends StatelessWidget {
   ItemCard(
      {required this.image, required this.label, this.isblue});
  final String image;
  final String label;
  final bool? isblue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.0.wp,
      height: 25.0.wp,
      margin: EdgeInsets.all(2.0.wp),
      padding: EdgeInsets.all(2.0.wp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0.wp),
          gradient: isblue!
              ?  LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      AppColors.cardGradientblue1,
                      AppColors.cardGradientcommon2
                    ])
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      AppColors.cardGradientred1,
                      AppColors.cardGradientcommon2
                    ])),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image),
                SizedBox(height: 2.0.wp),
                Image.asset(AppImages.cardImageshadow)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              label,
              style: AppStyle.shortHeading.copyWith(
                color: Colors.black,
                fontSize: 12.0.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

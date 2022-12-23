import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';


import '../constant/theme_manager.dart';
import '../screens/home_start/home_manager.dart';

class CarasoulImages extends StatelessWidget {
 // CarasoulImages({super.key});
  final getController = Get.put(HomeManager());

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      carosuelWidget1(),
      carosuelWidget1(),
      carosuelWidget1()
      // const CarosuelItem(bgImage: AppImages.bgflower),
      // const CarosuelItem(bgImage: AppImages.nearestAtmBg),
    ];
    return Stack(
      children: [
        CarouselSlider(
            items: items,
            options: CarouselOptions(
              height: 30.0.wp,
              viewportFraction: 1,
              autoPlay: true,
              initialPage: 0,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                getController.index.value = index;
              },
            )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.map((element) {
                  int index = items.indexOf(element);
                  return Obx(() {
                    return Container(
                      width: 2.0.wp,
                      height: 2.0.wp,
                      margin: EdgeInsets.symmetric(
                          vertical: 2.0.wp, horizontal: 1.0.wp),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getController.index.value == index
                              ? AppColors.yellowgradient1
                              : AppColors.backGrounddarkheader),
                    );
                  });
                }).toList()))
      ],
    );
  }

  Widget carosuelWidget1() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(MRouter.loanPage);
      },
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 2.0.hp),
        padding: EdgeInsets.symmetric(horizontal: 2.0.hp, vertical: 2.0.hp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0.wp),
            image:  DecorationImage(
                image: NetworkImage("https://picsum.photos/200"), fit: BoxFit.fitWidth)),
        child:
       null
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text('No need to roam for loans anymore',
        //         style: AppStyle.shortHeading.copyWith(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16)),
        //     SizedBox(height: 1.0.wp),
        //     Text('Get it on India1',
        //         style: AppStyle.shortHeading.copyWith(
        //             color: Colors.white, fontWeight: FontWeight.bold)),
        //     SizedBox(height: 2.0.wp),
        //     Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text('Apply Now',
        //             style: AppStyle.shortHeading.copyWith(
        //                 color: AppColors.yellowgradient1,
        //                 fontWeight: FontWeight.w400,
        //                 fontSize: 10.0.sp)),
        //         SizedBox(width: 2.0.wp),
        //         Image.asset(AppImages.rightArrow)
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class CarosuelItem extends StatelessWidget {
  const CarosuelItem({
    Key? key,
    required this.bgImage,
  }) : super(key: key);
  final String bgImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 2.0.hp),
      padding: EdgeInsets.symmetric(horizontal: 2.0.hp, vertical: 1.0.hp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0.wp),
          image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.fill)),
    );
  }
}

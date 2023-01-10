import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/banner_ads/bannerAdsView/bannerAdsWebView.dart';
import 'package:india_one/utils/common_webview.dart';

import '../constant/theme_manager.dart';
import '../screens/home_start/home_manager.dart';

class CarasoulImages extends StatelessWidget {
  // CarasoulImages({super.key});
  final getController = Get.find<HomeManager>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
            items: <Widget>[
              for (var i = 0; i < getController.bannerList.length; i++)
                GestureDetector(
                  onTap: () {
                    if (getController.bannerList[i].redirectUrl == null) {
                      Get.toNamed(getController.bannerList[i].route == null
                          ? MRouter.homeScreen
                          : getController.bannerList[i].route.toString());
                    } else {

                      Get.to(() => CommonWebView(
                          title: getController.bannerList[i].title.toString(),
                          url: getController.bannerList[i].redirectUrl
                              .toString()));
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 2.0.hp),
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.0.hp, vertical: 2.0.hp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0.wp),
                        image: DecorationImage(
                            image: NetworkImage(getController
                                .bannerList[i].imageUrl
                                .toString()),
                            fit: BoxFit.fill)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                            getController.bannerList[i].subTitle != null
                                ? getController.bannerList[i].subTitle
                                    .toString()
                                : "",
                            style: AppStyle.shortHeading.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        SizedBox(height: 1.0.wp),
                        text(
                            getController.bannerList[i].title != null
                                ? getController.bannerList[i].title.toString()
                                : "",
                            style: AppStyle.shortHeading.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 2.0.wp),
                        getController.bannerList[i].title == null
                            ? SizedBox()
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  text('Apply Now',
                                      style: AppStyle.shortHeading.copyWith(
                                          color: AppColors.yellowgradient1,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.0.sp)),
                                  SizedBox(width: 2.0.wp),
                                  Image.asset(AppImages.rightArrow)
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
            ],
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
                children: getController.bannerList.map((element) {
                  int index = getController.bannerList.indexOf(element);
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

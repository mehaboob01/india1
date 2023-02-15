import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/screens/onboarding_login/select_language/language_selection_io.dart';

import '../constant/routes.dart';
import '../constant/theme_manager.dart';
import '../screens/home_start/home_manager.dart';
import '../screens/notification/notification_manager.dart';

import '../screens/profile/profile_screen.dart';
import 'common_heading_action_icons.dart';

import 'loyalty_common_header.dart';

class CommonPageHeader extends StatelessWidget {
  HomeManager _homeManager = Get.put(HomeManager());

  final notificationManager = Get.put(NotificationManager());

  CommonPageHeader({required this.pageName});
  final PageName pageName;
  // heading value ----------------------------------------------------------
  final List<String> heading = <String>[
    'Loans',
    'Payments',
    'Insurance',
    'Savings'
  ];
  String headerName(PageName pageName) {
    String value = '';
    switch (pageName) {
      case PageName.loans:
        {
          value = heading[0];
        }
        break;
      case PageName.payments:
        {
          value = heading[1];
        }
        break;
      case PageName.insurance:
        {
          value = heading[2];
        }
        break;
      case PageName.savings:
        {
          value = heading[3];
        }
        break;
    }
    return value;
  }

// heading header value ---------------------------------------------------------------------------
  final List<String> headingHeader = <String>[
    "loans_banner_text",
    "payment_banner_text",
    "insurance_banner_text",
    "saving_banner_text" 
  ];
  String headerHeaderName(PageName pageName) {
    String value = '';
    switch (pageName) {
      case PageName.loans:
        {
          value = headingHeader[0];
        }
        break;
      case PageName.payments:
        {
          value = headingHeader[1];
        }
        break;
      case PageName.insurance:
        {
          value = headingHeader[2];
        }
        break;
      case PageName.savings:
        {
          value = headingHeader[3];
        }
        break;
    }
    return value;
  }

//heading image string value ----------------------------------------------------------------------------
  final List<String> headingImage = <String>[
    AppImages.loansPageSvg,
    AppImages.paymentsPageSvg,
    AppImages.insurancePageSvg,
    AppImages.savingsPageSvg
  ];
  String headerImageName(PageName pageName) {
    String value = '';
    switch (pageName) {
      case PageName.loans:
        {
          value = headingImage[0];
        }
        break;
      case PageName.payments:
        {
          value = headingImage[1];
        }
        break;
      case PageName.insurance:
        {
          value = headingImage[2];
        }
        break;
      case PageName.savings:
        {
          value = headingImage[3];
        }
        break;
    }
    return value;
  }

  // India1 title
  final List<String> indiaOneTitleList = <String>[
    'Get_it_on_India1',
    'Now_with_India1',
    'Now_with_India1',
    'When_with_India1'
  ];
  String indiaOneTitle(PageName pageName) {
    String value = '';
    switch (pageName) {
      case PageName.loans:
        {
          value = indiaOneTitleList[0];
        }
        break;
      case PageName.payments:
        {
          value = indiaOneTitleList[1];
        }
        break;
      case PageName.insurance:
        {
          value = indiaOneTitleList[2];
        }
        break;
      case PageName.savings:
        {
          value = indiaOneTitleList[3];
        }
        break;
    }
    return value;
  }

  // heading box -----------------------------------
  // Widget headingBox(
  //     {IconData? icon,
  //       String? image,
  //       String? text,
  //       VoidCallback? ontap,
  //       Color? color}) {
  //   return GestureDetector(
  //     onTap: ontap,
  //     child: Container(
  //       width: 30,
  //       height: 30,
  //       decoration: BoxDecoration(
  //           color: color ?? Colors.white,
  //           borderRadius: BorderRadius.circular(5)),
  //       child: text != null
  //           ? Center(
  //           child: text(
  //             text,
  //             style: const TextStyle(fontWeight: FontWeight.bold),
  //           ))
  //           : image != null
  //           ? Center(
  //           child: SvgPicture.asset(
  //             image,
  //             color: Colors.black,
  //           ))
  //           : Icon(icon),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Obx(() {
        //   return CustomAppBar(
        //     heading: '',
        //     hasLogo: true,
        //     haveHomeIcons: true,
        //     actionIcons: [
        //       HeadingBox(
        //           text: 'Aa',
        //           color: Color(0xff004280),
        //           ontap: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (BuildContext context) =>
        //                         LanguageSelectionIO('home')));
        //           }),
        //       Badge(
        //           position: BadgePosition.topEnd(top: -10, end: 0),
        //           badgeColor: Colors.red,
        //           showBadge:
        //               notificationManager.notificationsCount.length.toInt() !=
        //                   0,
        //           badgeContent: Container(
        //             child: text(
        //               "",
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           ),
        //           child: HeadingBox(
        //             image: AppImages.notify_icon,
        //             color: AppColors.blueColor,
        //             ontap: () => Get.toNamed(MRouter.notificationScreen),
        //           )),
        //       HeadingBox(
        //         color: _homeManager.isClicked.value
        //             ? Colors.orange
        //             : AppColors.blueColor,
        //         image: AppImages.user_profile,
        //         ontap: () {
        //           _homeManager.isClicked.value = true;
        //           showMenu<String>(
        //             context: context,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.only(
        //                     bottomLeft: Radius.circular(13.0),
        //                     bottomRight: Radius.circular(13.0),
        //                     topLeft: Radius.circular(13.0))),
        //             position: RelativeRect.fromLTRB(25.0, 100.0, 16.0, 0.0),
        //             items: [
        //               PopupMenuItem(
        //                 height: Get.height * 0.02,
        //                 child: GestureDetector(
        //                   onTap: () {
        //                     _homeManager.showAuth.value = false;
        //                     _homeManager.isClicked.value = false;
        //                     Get.back();
        //                     Get.to(() => ProfileScreen());
        //                   },
        //                   child: Container(
        //                     height: Get.height * 0.03,
        //                     width: double.infinity,
        //                     child: text(
        //                       "My Profile",
        //                       style: AppStyle.shortHeading.copyWith(
        //                           fontSize: Dimens.font_14sp,
        //                           color: Colors.black,
        //                           fontWeight: FontWeight.w400,
        //                           letterSpacing: 1),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               PopupMenuDivider(),
        //               PopupMenuItem(
        //                 height: 0.02,
        //                 child: GestureDetector(
        //                     onTap: () => {
        //                           _homeManager.showAuth.value = false,
        //                           _homeManager.isClicked.value = false,
        //                           Get.back(),
        //                           Get.toNamed(
        //                             MRouter.loyaltyPoints,
        //                           ),
        //                         },
        //                     child: Container(
        //                       height: Get.height * 0.03,
        //                       width: double.infinity,
        //                       child: text(
        //                         "My Rewards",
        //                         style: AppStyle.shortHeading.copyWith(
        //                             fontSize: Dimens.font_14sp,
        //                             color: Colors.black,
        //                             fontWeight: FontWeight.w400,
        //                             letterSpacing: 1),
        //                       ),
        //                     )),
        //               ),
        //             ],
        //             elevation: 8.0,
        //           ).then<void>((String? itemSelected) {
        //             if (itemSelected == null) {
        //               _homeManager.isClicked.value = false;
        //               return;
        //             }

        //             if (itemSelected == "1") {
        //             } else if (itemSelected == "2") {
        //               Get.toNamed(MRouter.loyaltyPoints);

        //               print("2nd itme ");
        //             } else if (itemSelected == "3") {
        //             } else {
        //               //code here
        //             }
        //           });
        //         },
        //       ),
        //     ],
        //   );
        // }),
        // ------------------------------------------- ||| |-------------------------------------
        Container(
          padding: EdgeInsets.fromLTRB(4.0.wp, 2.0.hp, 4.0.wp, 2.0.hp),
          width: double.maxFinite,
          height: Get.height * 0.4,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(AppImages.newHomeBgPng), fit: BoxFit.fill),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0.wp),
                  bottomRight: Radius.circular(5.0.wp))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonRoundedLogo(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeadingBox(
                          text: 'Aa',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LanguageSelectionIO('home')));
                          }),
                      SizedBox(
                        width: 2.0.wp,
                      ),
                      notificationManager.notificationsCount.length.toInt() != 0
                          ? GestureDetector(
                              onTap: () =>
                                  Get.toNamed(MRouter.notificationScreen),
                              child: Badge(
                                position:
                                    BadgePosition.topEnd(top: -10, end: 0),
                                badgeColor: Colors.red,
                                badgeContent: Container(
                                  child: text(
                                    "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                child: HeadingBox(image: AppImages.notify_icon),
                              ),
                            )
                          : GestureDetector(
                              onTap: () =>
                                  Get.toNamed(MRouter.notificationScreen),
                              child: HeadingBox(image: AppImages.notify_icon),
                            ),
                      SizedBox(
                        width: 2.0.wp,
                      ),
                      GestureDetector(
                        onTap: () {
                          _homeManager.isClicked.value = true;
                          showMenu<String>(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(13.0),
                                    bottomRight: Radius.circular(13.0),
                                    topLeft: Radius.circular(13.0))),
                            position:
                                RelativeRect.fromLTRB(25.0, 118.0, 16.0, 0.0),
                            items: [
                              PopupMenuItem(
                                height: Get.height * 0.02,
                                child: GestureDetector(
                                  onTap: () {
                                    _homeManager.isClicked.value = false;
                                    Get.back();
                                    Get.to(() => ProfileScreen());
                                  },
                                  child: Container(
                                    height: Get.height * 0.03,
                                    width: double.infinity,
                                    child: text(
                                      "My Profile",
                                      style: AppStyle.shortHeading.copyWith(
                                          fontSize: Dimens.font_14sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuDivider(),
                              PopupMenuItem(
                                height: 0.02,
                                child: GestureDetector(
                                    onTap: () => {
                                          _homeManager.isClicked.value = false,
                                          Get.back(),
                                          Get.toNamed(
                                            MRouter.loyaltyPoints,
                                          ),
                                        },
                                    child: Container(
                                      height: Get.height * 0.02,
                                      width: double.infinity,
                                      child: text(
                                        "My Rewards",
                                        style: AppStyle.shortHeading.copyWith(
                                            fontSize: Dimens.font_14sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1),
                                      ),
                                    )),
                              ),
                            ],
                            elevation: 8.0,
                          ).then<void>((String? itemSelected) {
                            if (itemSelected == null) {
                              _homeManager.isClicked.value = false;
                              return;
                            }

                            if (itemSelected == "1") {
                            } else if (itemSelected == "2") {
                              Get.toNamed(MRouter.loyaltyPoints);

                              print("2nd itme ");
                            } else if (itemSelected == "3") {
                            } else {
                              //code here
                            }
                          });
                        },
                        child: Obx(
                          () => HeadingBox(
                              color: _homeManager.isClicked.value
                                  ? Colors.orange
                                  : Colors.white,
                              image: AppImages.user_profile),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // text(headerName(pageName),
            //     style: AppStyle.shortHeading.copyWith(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w600,
            //         fontSize: Dimens.font_16sp)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 4.0.wp, 0, 0.0.wp),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Container(
                          // color: Colors.red,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.0.hp),
                              Padding(
                                padding: EdgeInsets.only(right: 2.0.wp),
                                child: text(headerHeaderName(pageName).tr,
                                    style: AppStyle.shortHeading.copyWith(
                                        color: Colors.white,
                                        fontSize: 14.0.sp,
                                        height: 1.5,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(height: 2.0.hp),
                              text(indiaOneTitle(pageName).tr,
                                  style: AppStyle.shortHeading.copyWith(
                                      color: const Color(0xffFFEF37),
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )),
                        )),
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          // color: Colors.yellow,
                          //   child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SvgPicture.asset(
                                headerImageName(pageName),
                                fit: BoxFit.contain,
                              )),
                        ))
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class CommonPageCategoriesHeading extends StatelessWidget {
  CommonPageCategoriesHeading({required this.pageName});
  final PageName pageName;
  final List<String> categoreisHeading = <String>[
    'loan_categories',
    'payment_categories',
    'insurance_categories',
    'savings'
  ];
  String categoreisTitle(PageName pageName) {
    String value = '';
    switch (pageName) {
      case PageName.loans:
        {
          value = categoreisHeading[0];
        }
        break;
      case PageName.payments:
        {
          value = categoreisHeading[1];
        }
        break;
      case PageName.insurance:
        {
          value = categoreisHeading[2];
        }
        break;
      case PageName.savings:
        {
          value = categoreisHeading[3];
        }
        break;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 4.0.hp, bottom: 2.0.hp, left: 4.0.wp, right: 4.0.wp),
      child: text(categoreisTitle(pageName).tr,
          style: AppStyle.shortHeading.copyWith(
              color: AppColors.blackColor,
              fontSize: Dimens.font_20sp,
              fontWeight: FontWeight.w600)),
    );
  }
}

enum PageName { loans, insurance, payments, savings }

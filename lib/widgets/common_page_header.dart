import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';
import 'common_heading_icon.dart';


class CommonPageHeader extends StatelessWidget {
  CommonPageHeader({ required this.pageName});
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
    "No need to roam for loans anymore",
    "Earn with every transaction",
    "Insure yourself & your loved ones",
    "The more you save, more you earn"
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
    'Get it on India1',
    'Now with India1',
    'Now with India1',
    'When with India1'
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(4.0.wp, 10.0.hp, 4.0.wp, 4.0.hp),
      width: double.maxFinite,
      height: Get.height * 0.4,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(AppImages.homebg), fit: BoxFit.fill),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0.wp),
              bottomRight: Radius.circular(5.0.wp))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(headerName(pageName),
                  style: AppStyle.shortHeading.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0.sp)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                 HeadingIconsBox(text: 'Aa'),
                SizedBox(
                  width: 2.0.wp,
                ),
                const HeadingIconsBox(image: AppImages.notificationBell),
                SizedBox(width: 2.0.wp),
                const HeadingIconsBox(image: AppImages.profileImage)
              ],
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 4.0.wp, 0, 4.0.wp),
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
                                child: Text(headerHeaderName(pageName),
                                    style: AppStyle.shortHeading.copyWith(
                                        color: Colors.white,
                                        fontSize: 14.0.sp,
                                        height: 1.5,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(height: 2.0.hp),
                              Text(indiaOneTitle(pageName),
                                  style: AppStyle.shortHeading.copyWith(
                                      color: const Color(0xffFFEF37),
                                      fontSize: Dimens.font_20sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )),
                    )),
                Expanded(
                   flex: 2
                    ,
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
    );
  }
}

class CommonPageCategoriesHeading extends StatelessWidget {
  CommonPageCategoriesHeading({ required this.pageName});
  final PageName pageName;
  final List<String> categoreisHeading = <String>[
    'Loan categories',
    'Payment categories',
    'Insurance categories',
    'Savings'
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
      child: Text(categoreisTitle(pageName),
          style: AppStyle.shortHeading.copyWith(
              color: AppColors.blackColor,
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600)),
    );
  }
}

enum PageName { loans, insurance, payments, savings }

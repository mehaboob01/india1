import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/utils/common_methods.dart';
import 'package:intl/intl.dart';

const String todate = "2022-11-10T15:36:13.660Z"; //20:45:13.660Z;

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.notificationHeading,
      required this.readStatus,
      required this.notificationMsg,
      required this.dateTime});
  final String notificationHeading;
  final String notificationMsg;
  final String dateTime;
  final String readStatus;



  bool isActive(String dateTime) {
    DateTime dateNow = DateTime.now();
    DateTime startDateTemp = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(CommonMethods().getDateFormat(dateTime));
    final difference = dateNow.difference(startDateTemp);
    if (readStatus != "Unread") {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Material(
        elevation: 6,
        type: MaterialType.transparency,
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.02, horizontal: width * 0.01),
            color: isActive(dateTime) ? Color(0xffFEF7E9) : Colors.white,
            width: width,
            height: height * 0.16,
            child: Row(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: width * 0.2,
                  child: _notificationIcon(isActive: isActive(dateTime)),
                ),
              ),
              Expanded(
                  child: Container(
                      color:
                          isActive(dateTime) ? Color(0xffFEF7E9) : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(CommonMethods().getFormatedDate(date: dateTime),
                              style: AppStyle.shortHeading.copyWith(
                                  fontSize: Dimens.font_12sp,
                                  color: Color(0xff666666),
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10),
                          Text(notificationHeading,
                              style: AppStyle.shortHeading.copyWith(
                                  fontSize: Dimens.font_14sp,
                                  color: isActive(dateTime)
                                      ? AppColors.blackColor
                                      : Color(0xff666666),
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10),
                          Text(notificationMsg,
                              style: AppStyle.shortHeading.copyWith(
                                  fontSize: Dimens.font_16sp,
                                  color: Color(0xff666666),
                                  fontWeight: FontWeight.w400))
                        ],
                      )))
            ])));
  }

  Widget _notificationIcon({required bool isActive}) {
    return Container(
        width: isActive ? 45 : 40,
        height: isActive ? 45 : 40,
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: isActive
            ? Image.asset(AppImages.notificationActive)
            : Image.asset(AppImages.notificationWithBorderImage));
  }

}

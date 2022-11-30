import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:india_one/screens/notification/notiication_card.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/theme_manager.dart';
import 'notification_manager.dart';

class NotificationScreen extends StatefulWidget {


  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationManager.callNotificationsApi();
  }
  NotificationManager _notificationManager = Get.put(NotificationManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(heading: 'Notifications'),
            SizedBox(height: 10),

            Text("No notifications!")
            // Expanded(
            //   child: Obx(
            //
            //
            //    ()=>  _notificationManager.isLoading.value == true ?
            //    Shimmer.fromColors(
            //      baseColor: AppColors.greySecond.withOpacity(0.5),
            //      highlightColor: AppColors.darkGrey!,
            //      child: ListView.builder(
            //        itemCount: _notificationManager.notificationList.length,
            //        itemBuilder: (context, index) {
            //          return Card(
            //            elevation: 1.0,
            //            shape: RoundedRectangleBorder(
            //              borderRadius: BorderRadius.circular(16),
            //            ),
            //            child: SizedBox(height: 80),
            //          );
            //        },
            //      ),
            //    ):
            //
            //        _notificationManager.notificationList.length == 0 ? Center(child: Text("No notifications!",style: TextStyle(
            //            fontSize: Dimens.font_20sp,
            //            fontWeight: FontWeight.w600,
            //            color: AppColors.greyText),)):
            //
            //
            //
            //        // ListView.separated(
            //        //  itemBuilder: (context, index) => NotificationCard(notificationHeading: _notificationManager.notificationList[index].title!, notificationMsg: _notificationManager.notificationList[index].body!,
            //        //
            //        //  ),
            //        //  separatorBuilder: (context, index) => Divider(
            //        //        height: 0,
            //        //        thickness: 2,
            //        //        color: Color(0xffe4e4e4),
            //        //      ),
            //        //  itemCount: _notificationManager.notificationList.length),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

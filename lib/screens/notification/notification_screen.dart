import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:india_one/screens/notification/notiication_card.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

import 'notification_manager.dart';

class NotificationScreen extends StatelessWidget {

  NotificationManager _notificationManager = Get.put(NotificationManager());

  NotificationScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(heading: 'Notifications'),
            SizedBox(height: 10),
            Expanded(
              child: Obx(
               ()=> ListView.separated(
                    itemBuilder: (context, index) => NotificationCard(notificationHeading: _notificationManager.notificationList[index].title!, notificationMsg: _notificationManager.notificationList[index].body!, dateTime: _notificationManager.notificationList[index].date!,

                    ),
                    separatorBuilder: (context, index) => Divider(
                          height: 0,
                          thickness: 2,
                          color: Color(0xffe4e4e4),
                        ),
                    itemCount: _notificationManager.notificationList.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}

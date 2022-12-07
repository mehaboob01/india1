import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:india_one/screens/notification/notiication_card.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/theme_manager.dart';
import '../../utils/common_methods.dart';
import 'notification_manager.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _page = 0;
  final int _limit = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notificationManager.callNotificationsApi();
    });
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
            Expanded(
              child: Obx(
                () => _notificationManager.isLoading.value == true
                    ?
              CircularProgressbar()
                    : _notificationManager.notificationList.length == 0
                        ? Center(
                            child: Text(
                            "No notifications!",
                            style: TextStyle(
                                fontSize: Dimens.font_20sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyText),
                          ))
                        : Obx(
                            () => ListView.separated(
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: ()  {
                                         _notificationManager
                                            .callNotificationMarkAsRead(
                                                _notificationManager
                                                    .notificationList[index]
                                                    .id);
                                      },
                                      child: NotificationCard(
                                        notificationHeading:
                                            _notificationManager
                                                .notificationList[index].title!,
                                        notificationMsg: _notificationManager
                                            .notificationList[index].body!,
                                        dateTime: _notificationManager
                                            .notificationList[index].date!,
                                      ),
                                    ),
                                separatorBuilder: (context, index) => Divider(
                                      height: 0,
                                      thickness: 2,
                                      color: Color(0xffe4e4e4),
                                    ),
                                itemCount: _notificationManager
                                    .notificationList.length),
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

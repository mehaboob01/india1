import 'package:flutter/material.dart';

import 'package:india_one/screens/notification/notiication_card.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<NotificationCard> notificationList = [
    NotificationCard(
      dateTime: "2022-11-10T15:36:13Z",
      notificationHeading: 'Congrats! You earned points',
      notificationMsg: 'You just earned 10 points for referring',
    ),
    NotificationCard(
      dateTime: "2022-11-09T23:36:13Z",
      notificationHeading: 'Loan application',
      notificationMsg: 'Your loan application is rejected',
    ),
    NotificationCard(
      dateTime: "2022-10-08T15:36:13Z",
      notificationHeading: 'Insurance purchase',
      notificationMsg: 'Your insurance purchase is pending',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(heading: 'Notifications'),
            SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => notificationList[index],
                  separatorBuilder: (context, index) => Divider(
                        height: 0,
                        thickness: 2,
                        color: Color(0xffe4e4e4),
                      ),
                  itemCount: notificationList.length),
            )
          ],
        ),
      ),
    );
  }
}

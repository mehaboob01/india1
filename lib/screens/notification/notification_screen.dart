import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/notification/notiication_card.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/routes.dart';
import '../../constant/theme_manager.dart';
import 'notification_manager.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // commit code
  // jfjfjj

  // commit code

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;

  final scrollController = ScrollController();

  void _onLoading() async {
    // your api here
    //  _notificationManager.callNotificationsApi(false);

    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // your api here
    _refreshController.refreshCompleted();
    //  _notificationManager.callNotificationsApi(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_addListner);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notificationManager.callNotificationsApi(false);
    });
  }

  NotificationManager _notificationManager = Get.put(NotificationManager());

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    heading: 'Notifications',
                    hasLogo: true,
                    customActionIconsList: [
                      CustomActionIcons(
                          image: AppImages.bottomNavHomeSvg,
                          onHeaderIconPressed: () async {
                            Get.offNamedUntil(
                                MRouter.homeScreen, (route) => route.isFirst);
                          })
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Obx(
                      () => _notificationManager.isLoading.value == true
                          ? CircularProgressbar()
                          : _notificationManager.notificationList.length == 0
                              ? Center(
                                  child: text(
                                  "No notifications!",
                                  style: TextStyle(
                                      fontSize: Dimens.font_20sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.greyText),
                                ))
                              : Obx(
                                  () => ListView.separated(
                                      controller: scrollController,
                                      itemBuilder: (context, index) {
                                        if (index <
                                            _notificationManager
                                                .notificationList.length) {
                                          return GestureDetector(
                                            onTap: () {
                                              _notificationManager
                                                  .callNotificationMarkAsRead(
                                                      _notificationManager
                                                          .notificationList[
                                                              index]
                                                          .id);
                                            },
                                            child: NotificationCard(
                                              readStatus: _notificationManager
                                                  .notificationList[index]
                                                  .status!,
                                              notificationHeading:
                                                  _notificationManager
                                                      .notificationList[index]
                                                      .title!,
                                              notificationMsg:
                                                  _notificationManager
                                                      .notificationList[index]
                                                      .body!,
                                              dateTime: _notificationManager
                                                  .notificationList[index]
                                                  .date!,
                                            ),
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                            height: 0,
                                            thickness: 2,
                                            color: Color(0xffe4e4e4),
                                          ),
                                      itemCount: _notificationManager
                                                  .isPaginationLoading.value ==
                                              true
                                          ? _notificationManager
                                                  .notificationList.length +
                                              1
                                          : _notificationManager
                                              .notificationList.length),
                                ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addListner() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // _notificationManager.callNotificationsApi(true);

      print("call ");
      page = page + 1;
      print("page ${page}");
    } else {
      print("Don't call");
    }
  }
}

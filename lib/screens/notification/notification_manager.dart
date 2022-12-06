import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/data/local/shared_preference_keys.dart';
import 'package:http/http.dart' as http;
import '../../core/data/remote/api_constant.dart';
import 'notification_model.dart';

class NotificationManager extends GetxController {
  var isLoading = false.obs;
  var isFirstLoading = false.obs; // for lazy loading
  var notificationList = <Notification>[].obs;
  var notificationListSend = <Notification>[].obs;

  List notificationsCount = [].obs;
  List notificationsCountSend = [].obs;
  final int limit = 2;

  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    print("Notifications api call");
    callNotificationsApi();
  }

// api call for verify otp

  callNotificationsApi() async {
    notificationList.clear();
    notificationListSend.clear();
    notificationsCount.clear();
    notificationsCountSend.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    try {
      isLoading.value = true;
      var response = await http.post(Uri.parse(baseUrl + Apis.notifications),
          body: jsonEncode(
              {"customerId": customerId, "nextToken": null, "limit": limit}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });
      print("response of notifications${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        NotificationModel notificationModel =
            NotificationModel.fromJson(jsonData);

        if (notificationModel.status!.code == 2000) {
          prefs = await SharedPreferences.getInstance();
          prefs!.setString(SPKeys.NOTIFICATION_NEXT_TOKEN,
              notificationModel.data!.nextToken.toString());

          for (var index in notificationModel.data!.notifications!) {
            notificationListSend.add(index);
            if (index.status != "Read") {
              notificationsCountSend.add(index.status);
            }
          }
          notificationList.addAll(notificationListSend);
          notificationsCount.addAll(notificationsCountSend);

          print("notifications list==> ${notificationsCount.length}");
          print("notifications list==> ${notificationList.length}");
        } else {
          isLoading.value = false;
          Flushbar(
            title: "Error!",
            message: notificationModel.status!.message,
            duration: Duration(seconds: 3),
          )..show(Get.context!);
        }
      }
    } catch (e) {
      isLoading.value = false;
      Flushbar(
        title: "Error!",
        message: "Something went wrong",
        duration: Duration(seconds: 3),
      )..show(Get.context!);
    } finally {
      isLoading.value = false;
    }
  }
}

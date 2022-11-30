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
  var resendOtpLoading = false.obs;
  var wrongOtp = false.obs;
  var loyaltyPoints = '0'.obs;
  var notificationList = <Notification>[].obs;
  var notificationListSend = <Notification>[].obs;

  SharedPreferences? prefs;

  @override
  void onInit() {
    super.onInit();
    callNotificationsApi();
  }


// api call for verify otp

  callNotificationsApi() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    try {


      isLoading.value = true;



      var response = await http.post(Uri.parse(baseUrl + Apis.notifications),
          body: jsonEncode(
              {"customerId": customerId,
                "nextToken" : null,
                "limit" : 20
              }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("response of notifications${response.body}");


      if(response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        NotificationModel notificationModel = NotificationModel.fromJson(jsonData);

        if (notificationModel.status!.code == 2000) {
          prefs = await SharedPreferences.getInstance();
          prefs!.setString(SPKeys.NOTIFICATION_NEXT_TOKEN, notificationModel.data!.nextToken.toString());

          for (var index in notificationModel.data!.notifications!) {
            notificationListSend.add(index);
          }
          notificationList.addAll(notificationListSend);

        } else {
          wrongOtp.value = true;
          isLoading.value = false;
          Flushbar(
            title: "Error!",
            message: notificationModel.status!.message,
            duration: Duration(seconds: 3),
          )
            ..show(Get.context!);
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
      resendOtpLoading.value = false;
    }
  }
}
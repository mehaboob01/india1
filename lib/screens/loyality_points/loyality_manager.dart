import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import '../../core/data/remote/api_constant.dart';
import 'loyalty_dashboard_model.dart';

class LoyaltyManager extends GetxController {
  var isLoading = false.obs;

  var redeemablePoints = 0.obs;
  var pointsEarned = 0.obs;
  var pointsRedeemed = 0.obs;
  var recentRewardTransactionsList = <RecentRewardTransaction>[].obs;
  var recentRewardTransactionSend = <RecentRewardTransaction>[];
  var isOverlayOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    callLoyaltyDashboardApi();
  }

  callLoyaltyDashboardApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
    try {
      isLoading(true);
      var response = await http.post(Uri.parse(baseUrl + Apis.loyaltyDashBoard),
          body: jsonEncode({
            "customerId": customerId,
            "rewardTransactionCount": 4,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("Response ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("http response");
        var jsonData = jsonDecode(response.body);
        LoyaltyDashboardModel loyaltyDashboardModel =
            LoyaltyDashboardModel.fromJson(jsonData);
        if (loyaltyDashboardModel.status!.code == 2000) {
          print("model  response");

          redeemablePoints.value = loyaltyDashboardModel
              .data!.pointsSummary!.redeemablePoints!
              .toInt();
          pointsEarned.value =
              loyaltyDashboardModel.data!.pointsSummary!.pointsEarned!.toInt();
          pointsRedeemed.value = loyaltyDashboardModel
              .data!.pointsSummary!.pointsRedeemed!
              .toInt();
          recentRewardTransactionsList.clear();

          for (var index
              in loyaltyDashboardModel.data!.recentRewardTransactions!) {
            recentRewardTransactionSend.add(index);
          }

          recentRewardTransactionsList.addAll(recentRewardTransactionSend);

          isLoading(false);
        } else {
          Flushbar(
            title: "Alert!",
            message: loyaltyDashboardModel.status!.message,
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Server Error!",
          message: "Please try after again ...",
          duration: Duration(seconds: 2),
        )..show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        title: "Error!",
        message: "Something went wrong",
        duration: Duration(seconds: 2),
      )..show(Get.context!);
    } finally {
      isLoading(false);
    }
  }
}

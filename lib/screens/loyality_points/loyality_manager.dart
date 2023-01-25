import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import '../../core/data/remote/api_constant.dart';
import '../../core/data/remote/dio_api_call.dart';
import 'loyalty_dashboard_model.dart';

class LoyaltyManager extends GetxController {
  var isLoading = false.obs;

  var redeemablePoints = 0.obs;
  var pointsEarned = 0.obs;
  var pointsRedeemed = 0.obs;
  var recentRewardTransactionsList = <RecentRewardTransactions>[].obs;
  var recentRewardTransactionSend = <RecentRewardTransactions>[];
  var isOverlayOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    callLoyaltyDashboardApi();
  }

  // LOYALTY DASHBOARD API
  Future<void> callLoyaltyDashboardApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
    recentRewardTransactionsList.clear();
    recentRewardTransactionSend.clear();

    try {
      isLoading(true);

      Map<dynamic,dynamic> data = {
        "customerId": customerId,
        "rewardTransactionCount": 20,
      };

      print("sending data= >${data} ");

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.loyaltyDashBoard,
        method: Type.POST,
        data: jsonEncode({
          "customerId": customerId,
          "rewardTransactionCount": 4,
        }),
      );





      if (response != null) {
        LoyaltyDashboardModel loyaltyDashboardModel = LoyaltyDashboardModel.fromJson(response);


        redeemablePoints.value = loyaltyDashboardModel.pointsSummary!.redeemablePoints!.toInt();
        pointsEarned.value = loyaltyDashboardModel.pointsSummary!.pointsEarned!.toInt();
        pointsRedeemed.value = loyaltyDashboardModel.pointsSummary!.pointsRedeemed!.toInt();
        recentRewardTransactionsList.clear();
        recentRewardTransactionSend.clear();
        for (var index in loyaltyDashboardModel.recentRewardTransactions!) {
          recentRewardTransactionSend.add(index);
        }
        recentRewardTransactionsList.addAll(recentRewardTransactionSend);
        isLoading(false);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }
}

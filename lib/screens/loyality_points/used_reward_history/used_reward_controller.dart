import 'dart:convert';

import 'package:get/get.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/screens/loyality_points/used_reward_history/used_reward_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/dio_api_call.dart';

class UsedRewardController extends GetxController {
  final loadingData = false.obs;
  List<Transactions> usedpointsList = <Transactions>[].obs;

  void onInit() {
    super.onInit();
    getUsedRewardHistory();
  }

  Future<List<Transactions>> getUsedRewardHistory() async {
    final preference = await SharedPreferences.getInstance();
    String? customerId = preference.getString(SPKeys.CUSTOMER_ID);
    loadingData.value = true;
    try {
      List<Transactions> getList = [];

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.loyaltyHistory,
        method: Type.POST,
        data: json.encode({"customerId": customerId, "limit": 10}),
      );

      if (response != null) {
        UsedPointsHistoryModel usedPointsHistoryModel =
            UsedPointsHistoryModel.fromJson(response);
        getList = usedPointsHistoryModel.transactions!.map((e) => e).toList();
        usedpointsList.addAll(getList);
        loadingData.value = false;
      }
      return usedpointsList;
    } catch (e) {
      loadingData.value = false;
      throw e;
    }
  }
}

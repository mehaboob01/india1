import 'dart:convert';

import 'package:get/get.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/screens/loyality_points/used_reward_history/used_reward_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/data/local/shared_preference_keys.dart';

class UsedRewardController extends GetxController {
  final loadingData = false.obs;
  List<Transaction> usedpointsList =
      <Transaction>[].obs;

  void onInit() {
    super.onInit();
    getUsedRewardHistory();
  }

  Future<List<Transaction>> getUsedRewardHistory() async {
    final preference = await SharedPreferences.getInstance();
    String? customerId = preference.getString(SPKeys.CUSTOMER_ID);
    String? accessToken = preference!.getString(SPKeys.ACCESS_TOKEN);
    loadingData.value = true;
    try {
      List<Transaction> getList = [];
      var response = await http.post(
          Uri.parse(baseUrl + Apis.loyaltyHistory),
          body: json
              .encode({"customerId": customerId, "limit": 10}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()
          });

      var jsonData = jsonDecode(response.body);
      print('History data');
      print(jsonData);
      UsedPointsHistoryModel usedPointsHistoryModel =
          UsedPointsHistoryModel.fromJson(jsonData);
      getList = usedPointsHistoryModel.data!.transactions!
          .map((e) => e)
          .toList();
      usedpointsList.addAll(getList);
      loadingData.value = false;
      return usedpointsList;
    } catch (e) {
      loadingData.value = false;
      throw e;
    }
  }
}

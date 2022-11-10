import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_controller.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import '../../core/data/remote/api_constant.dart';
import 'package:http/http.dart' as http;

import 'home_model.dart';

class HomeManager extends GetxController {
  final size = Get.size;
  final carouselCtrl = CarouselController();
  final index = 0.obs;
  var isLoading = false.obs;
  final datadelete = 'to mushc'.obs;
  var pointsEarned = '0'.obs;
  var pointsRedeemed = '0'.obs;
  var redeemablePoints = '0'.obs;
  var atmRewards = '0'.obs;
  var loyalityPoints = '0'.obs;
  var isClicked = false.obs;

  @override
  void onInit() {
    super.onInit();
    callHomeApi();
  }

  void callHomeApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    String? points = prefs.getString(SPKeys.LOYALTY_POINT_GAINED);

    loyalityPoints.value = points.toString();
    try {
      isLoading.value = true;
      var response = await http.get(
          Uri.parse(baseUrl + Apis.dashboard + customerId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      var jsonData = jsonDecode(response.body);
      HomeModel homeModel = HomeModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        isLoading(false);
        pointsEarned.value =
            homeModel.data!.pointsSummary!.pointsEarned.toString();
        pointsRedeemed.value =
            homeModel.data!.pointsSummary!.pointsRedeemed.toString();
        redeemablePoints.value =
            homeModel.data!.pointsSummary!.redeemablePoints.toString();
        atmRewards.value =
            homeModel.data!.atmRewards!.rewardsMultipliers![0].toString();
      } else {
        isLoading(false);

        Flushbar(
          title: "Error!",
          message: "Something went wrong",
          duration: Duration(seconds: 1),
        )..show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        title: "Error!",
        message: "Something went wrong",
        duration: Duration(seconds: 1),
      )..show(Get.context!);
    } finally {
      isLoading(false);
    }
  }
}

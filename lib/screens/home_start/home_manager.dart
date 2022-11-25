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
  RxInt pointsEarned = 0.obs;
  RxInt pointsRedeemed = 0.obs;
  RxInt redeemablePoints = 0.obs;
  RxInt atmRewards = 0.obs;
  var loyalityPoints = '0'.obs;
  var isClicked = false.obs;
  var showAuth = false.obs;

  @override
  void onInit() {
    super.onInit();
    callHomeApi();
  }

  void callHomeApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    String? points = prefs.getString(SPKeys.LOYALTY_POINT_GAINED);
    print("Customer Id ${customerId}");

    loyalityPoints.value = "0";
    try {
      isLoading.value = true;
      var response = await http.get(
          Uri.parse(baseUrl + Apis.dashboard + customerId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("response home===>${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        HomeModel homeModel = HomeModel.fromJson(jsonData);
        print("data response");
        print("http success!!");
        print(homeModel.data);

        if (homeModel!.status!.code == 2000) {
          isLoading(false);
          print("http success in model!!");
          pointsEarned.value = homeModel.data!.pointsSummary!.pointsEarned!;
          pointsRedeemed.value = homeModel.data!.pointsSummary!.pointsRedeemed!;
          redeemablePoints.value =
              homeModel.data!.pointsSummary!.redeemablePoints!;
          atmRewards.value = homeModel.data!.atmRewards!.rewardsMultipliers![0];
        } else {
          Flushbar(
            title: "Error!",
            message: homeModel.status!.message.toString(),
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Server Error!",
          message: "Please try after sometime ...",
          duration: Duration(seconds: 1),
        )..show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        title: "Server Error!",
        message: "Please try after sometime",
        duration: Duration(seconds: 1),
      )..show(Get.context!);
    } finally {
      isLoading(false);
    }
  }
}

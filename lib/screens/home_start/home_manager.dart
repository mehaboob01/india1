import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:india_one/screens/Pages/recent_transaction_model.dart';
import 'package:india_one/screens/home_start/home_new_model.dart';

import 'package:india_one/screens/home_start/payment_model.dart';
import 'package:india_one/screens/loyality_points/loyalty_dashboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import '../../core/data/remote/api_constant.dart';
// import 'package:http/http.dart' as http;

import '../../core/data/remote/dio_api_call.dart';
import '../../utils/common_webview.dart';
import '../banner_ads/model/BannerAds.dart';

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
  RxInt loyalityPoints = 0.obs;
  var isClicked = false.obs;
  var showAuth = false.obs;

// banner list
  var bannerList = <Ads>[].obs;
  var bannerListSend = <Ads>[].obs;

// pop up list
  var popUpList = <RecentRewardTransaction>[].obs;
  var popUpListSend = <RecentRewardTransaction>[].obs;

  @override
  void onInit() {
    super.onInit();

    callHomeApi();
    callAdsBannerApi();
    callHomeDashboard();

    //sendTokens();
  }

  // HOME API
  Future<void> callHomeApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    int? points = prefs.getInt(SPKeys.LOYALTY_POINT_GAINED);

    loyalityPoints.value = points!;
    try {
      isLoading.value = true;
      var response = await DioApiCall().commonApiCall(
          endpoint: Apis.dashboard + customerId.toString(), method: Type.GET);
      if (response != null) {
        HomeModel homeModel = HomeModel.fromJson(response);
        pointsEarned.value = homeModel.pointsSummary!.pointsEarned!;
        pointsRedeemed.value = homeModel.pointsSummary!.pointsRedeemed!;
        redeemablePoints.value = homeModel!.pointsSummary!.redeemablePoints!;
        atmRewards.value = homeModel!.atmRewards!.rewardsMultipliers![0];
      }
    } catch (exception) {
      print(exception);
    } finally {
      isLoading(false);
    }
  }

  // this api call will contain popus conust as well to show
  Future<void> callHomeDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    popUpListSend.clear();
    popUpList.clear();
    try {
      isLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.dashboardHome,
        method: Type.POST,
        data: jsonEncode({"customerId": customerId, "numOfPopupsToShow": "2"}),
      );
      if (response != null) {
        print("response == > ${response}");

        NewHomeModel newHomeModel = NewHomeModel.fromJson(response);

        for (var index in newHomeModel.recentRewardTransactions!) {
          popUpListSend.add(index);
        }
        popUpList.addAll(popUpListSend);

        isLoading(false);
      }
    } catch (exception) {
      print(exception);
    } finally {
      isLoading(false);
    }
  }

  // update pop up

  Future<void> callUpdatePopup(String transactionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);

    try {

  print("INside update popuop");
      isLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.updatePopUp,
        method: Type.POST,
        data: jsonEncode({"customerId": customerId.toString(),"transactionId":transactionId.toString(),"isInteracted" : true}),
      );

      print("response  updtae popup== > ${response}");
      if (response != null) {

        print("ho gya intract");
        print("response == > ${response}");


        isLoading(false);
      }
    } catch (exception) {
      print(exception);
    } finally {
      isLoading(false);
    }
  }

  // ADS BANNER API
  Future<void> callAdsBannerApi() async {
    bannerListSend.clear();
    bannerList.clear();
    try {
      isLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.bannerAds,
        method: Type.POST,
        data: jsonEncode({"adPlacement": "Home"}),
      );
      if (response != null) {
        BanerAdsMOdel banerAdsMOdel = BanerAdsMOdel.fromJson(response);

        for (var index in banerAdsMOdel.ads!) {
          bannerListSend.add(index);
        }
        bannerList.addAll(bannerListSend);

        isLoading(false);
      }
    } catch (exception) {
      print(exception);
    } finally {
      isLoading(false);
    }
  }

  // BANNERS API
  Future<void> callPaymentApi(String api_route, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    print("customer id ${customerId}");

    try {
      isLoading.value = true;

      var response = await DioApiCall().commonApiCall(
        endpoint: api_route,
        method: Type.POST,
        data: jsonEncode({"customerId": customerId}),
      );

      if (response != null) {
        isLoading(false);
        PaymentModel paymentModel = PaymentModel.fromJson(response);

        Get.to(() => CommonWebView(
              title: api_route == Apis.payment_fastag
                  ? "FASTag"
                  : api_route == Apis.payment_dth
                      ? "DTH"
                      : "Recharge",
              url: paymentModel.link.toString(),
            ));
      }
    } catch (exception) {
      print(exception);
    } finally {
      isLoading(false);
    }
  }

  // SEND TOKENS
  Future<void> sendTokens() async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString(SPKeys.DEVICE_ID);
      String? deviceToken = prefs.getString(SPKeys.DEVICE_TOKEN);
      String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.sendToken,
        method: Type.PUT,
        data: jsonEncode({
          "customerId": customerId,
          "deviceId": deviceId,
          "deviceToken": deviceToken
        }),
      );

      if (response != null) {
        print("DONE SEND TOKENS");
      }
    } catch (exception) {
      print(exception);
    } finally {
      isLoading.value = false;
    }
  }
}

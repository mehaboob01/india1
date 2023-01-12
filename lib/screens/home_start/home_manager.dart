import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:india_one/core/data/model/common_model.dart';
import 'package:india_one/screens/home_start/payment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import '../../core/data/remote/api_constant.dart';
import 'package:http/http.dart' as http;

import '../../utils/common_webview.dart';
import '../banner_ads/model/BannerAds.dart';
import '../onboarding_login/user_login/tnc_io.dart';
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

  var bannerList = <Ad>[].obs;
  var bannerListSend = <Ad>[].obs;

  @override
  void onInit() {
    super.onInit();

    callHomeApi();
    callAdsBannerApi();
    sendTokens();
    //sendTokens();
  }

  void callHomeApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    String? accessToken = prefs.getString(SPKeys.ACCESS_TOKEN);
    int? points = prefs.getInt(SPKeys.LOYALTY_POINT_GAINED);
    print("Customer Id ${customerId}");
    print("points Id ${points}");
    print("Access token ${accessToken}");

    loyalityPoints.value = points!;
    try {
      isLoading.value = true;
      var response = await http.get(
          Uri.parse(baseUrl + Apis.dashboard + customerId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()
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

  void callAdsBannerApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    bannerListSend.clear();
    bannerList.clear();

    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse(baseUrl + Apis.bannerAds),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "x-digital-api-key": "1234",
          "Authorization": "Bearer "+accessToken.toString()

        },
        body: jsonEncode({"adPlacement": "Home"}),
      );

      print("response ads===>${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        BanerAdsMOdel banerAdsMOdel = BanerAdsMOdel.fromJson(jsonData);
        print("data response");
        print("http success!!");
        print(banerAdsMOdel.data);

        if (banerAdsMOdel!.status!.code == 2000) {
          for (var index in banerAdsMOdel.data!.ads!) {
            bannerListSend.add(index);
          }
          bannerList.addAll(bannerListSend);
          print("banerr lenth ${bannerList.length}");
          isLoading(false);
        } else {
          Flushbar(
            title: "Error!",
            message: banerAdsMOdel.status!.message.toString(),
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

  void sendTokens() async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString(SPKeys.DEVICE_ID);
      String? deviceToken = prefs.getString(SPKeys.DEVICE_TOKEN);
      String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);


      print("device Id ${deviceId}");
      var response = await http.put(Uri.parse(baseUrl + Apis.sendToken),
          body: jsonEncode({
            "customerId": customerId,
            "deviceId": deviceId,
            "deviceToken": deviceToken
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()

          });

      print("send tokens${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
        } else {
          Flushbar(
            title: "Server Error!",
            message: commonApiResponseModel.status!.message.toString(),
            duration: Duration(seconds: 1),
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
        message: "Please try after sometime ...",
        duration: Duration(seconds: 1),
      )..show(Get.context!);
    } finally {
      isLoading.value = false;
    }
  }

  void callPaymentApi(String api_route, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

    print("customer id ${customerId}");

    try {
      isLoading.value = true;

      print(baseUrl + api_route);
      var response = await http.post(
        Uri.parse(baseUrl + api_route),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "x-digital-api-key": "1234",
          "Authorization": "Bearer "+accessToken.toString()
        },
        body: jsonEncode({"customerId": customerId}),
      );

      //   print("response home===>${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        PaymentModel paymentModel = PaymentModel.fromJson(jsonData);

        if (paymentModel!.status!.code == 2000) {
          isLoading(false);
          print("http success in model!!");
          print("http success in model!!${paymentModel.data!.link.toString()}");
          Get.to(() => CommonWebView(
                title: api_route == Apis.payment_fastag
                    ? "FASTag"
                    : api_route == Apis.payment_dth
                        ? "DTH"
                        : "Recharge",
                url: paymentModel.data!.link.toString(),
              ));
        } else {
          Flushbar(
            title: "Error!",
            message: paymentModel.status!.message.toString(),
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

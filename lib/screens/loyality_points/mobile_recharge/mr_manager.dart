import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/loyality_points/loyality_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/api_calls.dart';
import '../../../core/data/remote/api_constant.dart';
import 'model/mobile_recharge_model.dart';
import 'model/operator_model.dart';
import 'model/circle_model.dart';
import 'model/recharge_plan_model.dart';

class MrManager extends GetxController {
  var contact = Contact().obs;

  var isLoading = false.obs;
  var isMobileRechargeLoading = false.obs;
  var isFetchPlanLoading = false.obs;
  var isPlansAvailable = false.obs;

  var operatorListString = <String>[].obs;
  var operatorListStringSend = <String>[];

  var operatorList = <Operator>[].obs;
  var operatorListSend = <Operator>[];

  var circleListString = <String>[].obs;
  var circleListStringSend = <String>[];

  var circleList = <Circle>[].obs;
  var circleListSend = <Circle>[];

  // planes

  var plansList = <Plan>[].obs;
  var plansListSend = <Plan>[];

  RxInt selectedIndex = (-1).obs;

  var selectedplanList = <bool>[].obs;
  final loyaltyManager = Get.find<LoyaltyManager>();

  RxMap<String, dynamic> rechargeData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    plansList.clear();

    callOperatorListApi();
    callCircleListApi();
  }
  Future<void> showAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs!.setBool(SPKeys.SHOW_AUTH, false);

  }
  // operator list
  callOperatorListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse(baseUrl + Apis.operatorList), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()

      });

      print("Operator response");
      print(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        RcOperatorModel rcOperatorModel = RcOperatorModel.fromJson(jsonData);
        if (rcOperatorModel.status!.code == 2000) {
          print(rcOperatorModel.data!.operators!);
          operatorList.clear();
          operatorListString.clear();
          for (var index in rcOperatorModel.data!.operators!) {
            operatorListSend.add(index);
            operatorListStringSend.add(index.name.toString());
          }
          operatorList.addAll(operatorListSend);
          operatorListString.addAll(operatorListStringSend);
          isLoading(false);
        } else {
          Flushbar(
            title: "Alert!",
            message: rcOperatorModel.status!.message,
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Error!",
          message: "Something went wrong",
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

  //circle list

  callCircleListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse(baseUrl + Apis.circleList), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        RcCircleModel circleModel = RcCircleModel.fromJson(jsonData);

        if (circleModel.status!.code == 2000) {
          circleList.clear();
          circleListString.clear();
          for (var index in circleModel.data!.circles!) {
            circleListSend.add(index);
            circleListStringSend.add(index.name.toString());
          }

          circleList.addAll(circleListSend);
          circleListString.addAll(circleListStringSend);

          isLoading(false);
        } else {
          Flushbar(
            title: "Alert!",
            message: circleModel.status!.message,
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {}
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

  // check planes

  checkPlanesApi(int? operatorId, int? circleId, mobileNumber) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    selectedIndex.value = (-1);

    plansList.clear();
    plansListSend.clear();
    isFetchPlanLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);

      print("Send Mobile Recharge data ${operatorId}");
      print("Send Mobile Recharge data ${circleId}");
      print("Send Mobile Recharge data ${mobileNumber}");
      print("Send Mobile Recharge data ${operatorId}");

      var response = await http.post(Uri.parse(baseUrl + Apis.plans),
          body: jsonEncode({
            "operatorId": operatorId,
            "circleId": circleId,
            "mobileNumber": mobileNumber,
            "customerId": customerId,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()
          });
      print("response ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        PlanesModel planesModel = PlanesModel.fromJson(jsonData);

        if (planesModel.status!.code == 2000) {
          List<bool> localSelectedList = [];

          plansList.clear();
          for (var index in planesModel.data!.plans!) {
            plansListSend.add(index);
            localSelectedList.add(false);
          }

          plansList.addAll(plansListSend);

          isPlansAvailable(true);
          selectedplanList.addAll(localSelectedList);

          print("plans List ");
          print(plansList.length);
          isFetchPlanLoading(false);
          if (plansList.length == 0) {
            Flushbar(
              title: "Alert!",
              message: "No planes in List",
              duration: Duration(seconds: 2),
            )..show(Get.context!);
          }
        } else {
          Flushbar(
            title: "Error!",
            message: planesModel.status!.message,
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Error!",
          message: "Something went wrong",
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
      isFetchPlanLoading.value = false;
    }
  }

  // mobile recharge

  mobileRechargeApi(int? operatorId, int? circleId, String? phoneNumber,
      RxMap<String, dynamic> rechargeData, BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    isMobileRechargeLoading(true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);

      isLoading.value = true;
      var response = await http.post(Uri.parse(baseUrl + Apis.recharge),
          body: jsonEncode({
            "operatorId": operatorId,
            "circleId": circleId,
            "mobileNumber": phoneNumber.toString(),
            "amount": int.parse(rechargeData['amount'].toString()),
            "planType": rechargeData['planType'].toString(),
            "customerId": customerId.toString(),
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()
          });

      print("REsponse of mobile recharge ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        MobileRechargeModel mobileRechargeModel =
            MobileRechargeModel.fromJson(jsonData);

        if (mobileRechargeModel.status!.code == 2000) {
          Future.delayed(const Duration(seconds: 0), () async {
            showAuth();

            isMobileRechargeLoading(false);
            Flushbar(
              title: "successful!",
              message: "Recharge successful",
              duration: Duration(seconds: 1),
            )..show(Get.context!)
                .then((value) => Get.toNamed(MRouter.verifiedScreen))
                .then((value) => () {
                      plansList.clear();
                    });
          });
        } else {
          isMobileRechargeLoading(false);
          Flushbar(
            title: "Error!",
            message: mobileRechargeModel.status!.message,
            duration: Duration(seconds: 4),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Server Error!",
          message: "Please try again ...",
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
      isLoading.value = false;
      isMobileRechargeLoading(false);
    }
  }
}

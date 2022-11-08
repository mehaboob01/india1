import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:india_one/constant/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/api_constant.dart';
import 'model/mr_model.dart';
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

  RxMap<String, dynamic> rechargeData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    plansList.clear();


    callOperatorListApi();
    callCircleListApi();
  }

  // operator list
  callOperatorListApi() async {
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse(baseUrl + Apis.operatorList), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "x-digital-api-key": "1234"
      });
      var jsonData = jsonDecode(response.body);

      RcOperatorModel rcOperatorModel = RcOperatorModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        print("Operator response");
        print(response.body.toString());
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
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse(baseUrl + Apis.circleList), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "x-digital-api-key": "1234"
      });
      var jsonData = jsonDecode(response.body);

      RcCircleModel circleModel = RcCircleModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        print("Circles response");
        print(response.body.toString());
        print(circleModel.data!.circles!);
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

  // check planes

  checkPlanesApi(String? operatorId, String? circleId, mobileNumber) async {
    isFetchPlanLoading.value = true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);

      var response = await http.post(Uri.parse(baseUrl + Apis.plans),
          body: jsonEncode({
            "operatorId": operatorId,
            "circleId": customerId,
            "mobileNumber": mobileNumber,
            "customerId": customerId,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });
      var jsonData = jsonDecode(response.body);

      PlanesModel planesModel = PlanesModel.fromJson(jsonData);

      if (response.statusCode == 200) {
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

    isMobileRechargeLoading(true);




    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      isLoading.value = true;
      var response = await http.post(Uri.parse(baseUrl + Apis.recharge),
          body: jsonEncode({
            "operatorId": operatorId,
            "circleId": circleId,
            "mobileNumber": phoneNumber,
            "amount": rechargeData['amount'],
            "planType": rechargeData['planType'],
            "customerId": customerId,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      if (response.statusCode == 200) {

        Future.delayed(const Duration(seconds: 0), () async {





          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs!.setBool(SPKeys.SHOW_AUTH, false);

          isMobileRechargeLoading(false);
          Flushbar(
            title: "successful!",
            message: "Recharge successful",
            duration: Duration(seconds: 2),
          )..show(Get.context!)
              .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
              MRouter.homeScreen, (Route<dynamic> route) => false))
              .then((value) => (){


            plansList.clear();
          }

          );



        });



      } else {
        isMobileRechargeLoading(false);
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
      isLoading.value = false;
      isMobileRechargeLoading(false);
    }
  }
}

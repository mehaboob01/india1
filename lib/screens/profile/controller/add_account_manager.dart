import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/model/common_model.dart';
import '../../../core/data/remote/api_constant.dart';
import 'package:http/http.dart' as http;

class AddAccountManager extends GetxController {
  var isLoading = false.obs;
  RxInt selectedIndex = (-1).obs;


  SharedPreferences? prefs;

  addBankAccount(Map<String, dynamic> data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);




      isLoading(true);
      var response = await http.post(Uri.parse(baseUrl + Apis.upiAdd),
          body: jsonEncode({
            "customerId": customerId,
            "bankAccount": {
              "bankId": "6",
              "accountNumber": "344534334234442342341234",
              "ifscCode": "YESB234234",
              "accountType": "current"
            }
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer "+accessToken.toString()

          });

      print("Response ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("http response");
        var jsonData = jsonDecode(response.body);

        CommonApiResponseModel commonApiResponseModel =
        CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          Flushbar(
            title: "Success!",
            message: "Upi added Successfully ...",
            duration: Duration(seconds: 2),
          )..show(Get.context!).then((value) => Get.back());

          isLoading(false);
        } else {
          Flushbar(
            title: "Alert!",
            message: commonApiResponseModel.status!.message,
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
      // Flushbar(
      //   title: "Error!",
      //   message: "Something went wrong",
      //   duration: Duration(seconds: 2),
      // )..show(Get.context!);
    } finally {
      isLoading(false);
    }
  }



  //api call for verify otp


}
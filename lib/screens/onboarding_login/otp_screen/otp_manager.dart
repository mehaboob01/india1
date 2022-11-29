import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:india_one/core/data/local/shared_preference_keys.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/routes.dart';
import 'otp_model.dart';

class OtpManager extends GetxController {
  var isLoading = false.obs;
  var resendOtpLoading = false.obs;
  var wrongOtp = false.obs;
  var loyaltyPoints = '0'.obs;

  SharedPreferences? prefs;

  //api call for resend otp
  Future<bool> callResendOtpApi(String phoneNumber, BuildContext context,
      bool? termConditionChecked) async {
    try {
      resendOtpLoading.value = true;
      wrongOtp.value = false;

      Map<String, dynamic> otpData = {};
      otpData['mobile'] = phoneNumber;
      otpData['agreedToToc'] = termConditionChecked;

      Map<String, dynamic> headersData = {};

      headersData['x-digital-api-key'] = '1234';

      dynamic response = await http.post(Uri.parse(baseUrl + Apis.sendOtp),
          body: jsonEncode({
            "mobileNumber": phoneNumber,
            "agreedToToc": termConditionChecked
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          }).then((value) {
        if (value.statusCode == 200) {
          var snackBar = SnackBar(
            content: Text("OTP Resent Successfully!"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return true;
        } else {
          var snackBar = SnackBar(
            content: Text("Something went wrong!"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
      });
      return true;
    } catch (e) {
      Flushbar(
        title: "Error",
        message: "Please try again..",
        duration: Duration(seconds: 3),
      )..show(context);
      // showSnackBar("Something went wrong");
    } finally {
      resendOtpLoading.value = false;
    }
    return false;
  }

  //api call for verify otp

  callVerifyOtpApi(String otpNumber, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenKey = prefs!.getString(SPKeys.TOKEN_KEY);
      isLoading.value = true;
      Map<String, dynamic> verifyHeadersData = {
        "token": tokenKey,
        "otp": otpNumber,
        "preferredLanguage": "kn"
      };
      Map<String, dynamic> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "x-digital-api-key": "1234"
      };

      verifyHeadersData['x-digital-api-key'] = '1234';

      var response = await http.post(Uri.parse(baseUrl + Apis.verifyOtp),
          body: jsonEncode(
              {"token": tokenKey, "otp": otpNumber, "preferredLanguage": "kn"}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });
      var jsonData = jsonDecode(response.body);
      VerifyOtpModel verifyOtpModel = VerifyOtpModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        prefs = await SharedPreferences.getInstance();
        prefs!.setString(
            SPKeys.ACCESS_TOKEN, verifyOtpModel.data!.accessToken.toString());
        prefs!.setString(
            SPKeys.REFRESH_TOKEN, verifyOtpModel.data!.refreshToken.toString());
        prefs!.setString(
            SPKeys.CUSTOMER_ID, verifyOtpModel.data!.customerId.toString());
        loyaltyPoints.value =
            verifyOtpModel.data!.loyaltyPointsGained.toString();
        prefs!.setString(SPKeys.LOYALTY_POINT_GAINED,
            verifyOtpModel.data!.loyaltyPointsGained.toString());
        prefs!.setBool(SPKeys.LOGGED_IN, true);
        Get.offAllNamed(MRouter.homeScreen);
      } else if (response.statusCode == 400) {
        wrongOtp.value = true;
        isLoading.value = false;
        Flushbar(
          title: 'wrong',
        );
      } else {
        isLoading.value = false;
        Flushbar(
          title: "Error!",
          message: "Something went wrong ",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } catch (e) {
      isLoading.value = false;
      Flushbar(
        title: "Error!",
        message: "Something went wrong ",
        duration: Duration(seconds: 3),
      )..show(context);
    } finally {
      isLoading.value = false;
      resendOtpLoading.value = false;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:india_one/core/data/local/shared_preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/routes.dart';
import 'otp_model.dart';

class OtpManager extends GetxController {
  var isLoading = false.obs;
  var resendOtpLoading = false.obs;
  var wrongOtp = false.obs;

  callResendOtpApi(String phoneNumber, BuildContext context,
      bool? termConditionChecked) async {
    try {
      resendOtpLoading.value = true;

      Map<String, dynamic> otpData = {};
      otpData['mobile'] = phoneNumber;
      otpData['agreedToToc'] = termConditionChecked;

      Map<String, dynamic> headersData = {};

      headersData['x-digital-api-key'] = '1234';

      dynamic response = await http.post(
          Uri.parse(
              "http://india1digital-env.eba-5k3w2wxz.ap-south-1.elasticbeanstalk.com/auth/send-otp"),
          body: jsonEncode({
            "mobileNumber": phoneNumber,
            "agreedToToc": termConditionChecked
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          }).then((value) {
        print(value.statusCode);

        if (value.statusCode == 200) {
          var snackBar = SnackBar(
            content: Text("OTP Resend Successfully!"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var snackBar = SnackBar(
            content: Text("Something went wrong!"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } catch (e) {
      var snackBar = SnackBar(
        content: Text("Something went wrong!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // showSnackBar("Something went wrong");
    } finally {
      resendOtpLoading.value = false;
    }
  }

  callVerifyOtpApi(String OtpNumber, BuildContext context) async {


    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String? tokenKey = prefs.getString(SPKeys.TOKEN_KEY);
      isLoading.value = true;

      Map<String, dynamic> verifyHeadersData = {};

      verifyHeadersData['x-digital-api-key'] = '1234';

      var response = await http.post(
          Uri.parse(
              "http://india1digital-env.eba-5k3w2wxz.ap-south-1.elasticbeanstalk.com/auth/verify-otp"),
          body: jsonEncode(
              {"token": tokenKey, "otp": OtpNumber, "preferredLanguage": "kn"}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      var jsonData = jsonDecode(response.body);

      VerifyOtpModel verifyOtpModel = VerifyOtpModel.fromJson(jsonData);

      if (verifyOtpModel.status!.code == 2000) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            SPKeys.ACCESS_TOKEN, verifyOtpModel.data!.accessToken.toString());
        prefs.setString(
            SPKeys.REFRESH_TOKEN, verifyOtpModel.data!.refreshToken.toString());
        prefs.setString(
            SPKeys.CUSTOMER_ID, verifyOtpModel.data!.customerId.toString());

        Get.offAllNamed(MRouter.verifiedScreen);
      } else if (verifyOtpModel.status!.code == 4000) {
        wrongOtp.value = true;
      } else {
        var snackBar = SnackBar(
          content: Text("Something went wrong!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      var snackBar = SnackBar(
        content: Text("Something went wrong!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // showSnackBar("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}

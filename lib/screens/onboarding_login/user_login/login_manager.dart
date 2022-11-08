import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:india_one/screens/onboarding_login/user_login/user_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/local/shared_preference_keys.dart';

import '../otp_screen/otp_screen_ui.dart';

class LoginManager extends GetxController {
  var isLoading = false.obs;
  var getOtp = false.obs;

  callSentOtpApi(String phoneNumber, BuildContext context,
      bool? termConditionChecked) async {

    try {
      isLoading.value = true;

      var response = await http.post(
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
          });
      var jsonData = jsonDecode(response.body);

      LoginModel userSignInModelDto = LoginModel.fromJson(jsonData);

      print(userSignInModelDto.status!.code);

      if (userSignInModelDto.status!.code == 2000) {
        getOtp.value = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
            SPKeys.TOKEN_KEY, userSignInModelDto.data!.token.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => OtpScreen(phoneNumber,userSignInModelDto.data!.retryInSeconds)));
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
    } finally {
      isLoading.value = false;
    }
  }
}

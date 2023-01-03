import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:india_one/screens/onboarding_login/user_login/user_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/api_constant.dart';
import '../otp_screen/otp_screen_ui.dart';

class LoginManager extends GetxController {
  var isLoading = false.obs;
  var getOtp = false.obs;
  var resendOtpLoading = false.obs;

  callSentOtpApi(String phoneNumber, BuildContext context,
      bool? termConditionChecked, String appSignatureId, bool isResend) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString(SPKeys.DEVICE_ID);
      String? deviceToken = prefs.getString(SPKeys.DEVICE_TOKEN);
      String? selectedLan = prefs.getString(SPKeys.SELECTED_LANGUAGE_CODE);

      var response = await http.post(Uri.parse(baseUrl + Apis.sendOtp),
          body: jsonEncode({
            "mobileNumber": phoneNumber,
            "agreedToToc": termConditionChecked,
            "appSignature": appSignatureId,
            "deviceId": deviceId,
            "deviceToken": deviceToken,
            "platform": "Android",
            "preferredLanguage": selectedLan
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("response of send otp${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        LoginModel userSignInModelDto = LoginModel.fromJson(jsonData);

        if (userSignInModelDto.status!.code == 2000) {
          getOtp.value = true;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              SPKeys.TOKEN_KEY, userSignInModelDto.data!.token.toString());
          prefs.setInt(SPKeys.RETRY_IN_SECONDS,
              userSignInModelDto.data!.retryInSeconds!.toInt());
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => OtpScreen(
          //             phoneNumber, userSignInModelDto.data!.retryInSeconds)));
          if (isResend == false) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => OtpScreen(
                        phoneNumber, userSignInModelDto.data!.retryInSeconds)));
          }
          if (isResend == true) {
            var snackBar = SnackBar(
              content: Text("OTP Resend Successfully!"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          Flushbar(
            title: "Server Error!",
            message: userSignInModelDto.status!.message.toString(),
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
      var snackBar = SnackBar(
        content: Text("Something went wrong!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      isLoading.value = false;
    }
  }
}

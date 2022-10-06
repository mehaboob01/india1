import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:india_one/core/data/remote/api_constant.dart';

import '../../../core/data/remote/api_calls.dart';

class LoginManager extends GetxController {
  var isLoading = false.obs;

  callSentOtpApi(Map<String, dynamic> data, BuildContext context) async {
    try {
      isLoading.value = true;
      dynamic response = await ApiCalls.post(baseUrl + Apis.sendOtp);

      //  UserSignInModelDto userSignInModelDto = UserSignInModelDto.fromJson(response.data);
      //
      // print("staus");
      // print(signupResponseModel.status);
      // print(signupResponseModel.response);

      // if (userSignInModelDto.status == "true") {
      //   print("success");
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   prefs.setString('CurrentUser', "User");
      //   prefs.setString(SPKeys.USER_NAME, userSignInModelDto.userData!.name.toString());
      //   prefs.setString(SPKeys.USER_EMAIL, userSignInModelDto.userData!.email.toString());
      //   prefs.setString(SPKeys.USER_MOBILE, userSignInModelDto.userData!.mobile.toString());
      //   prefs.setString(SPKeys.USER_CITY, userSignInModelDto.userData!.city.toString());
      //
      //   print(userSignInModelDto.msg);
      //   //showSnackBar(userSignInModelDto.msg.toString());
      //   Get.toNamed(MRouter.userHomeScreen);
      // } else {
      //   var snackBar = SnackBar(
      //     content: Text(userSignInModelDto.msg.toString()),
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   print("failed");
      //   print(userSignInModelDto.msg);
      //   await Future.delayed(Duration(seconds: 2));
      //   print("error ");

    } catch (e) {
      // showSnackBar("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/model/common_model.dart';
import '../../../core/data/remote/api_constant.dart';

class UpdateUpiAccount extends GetxController {
  var isLoading = false.obs;

  // update upi
  callUpdateUpiAccount(Map<String, dynamic> data, String? id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);




      isLoading(true);
      var response = await http.put(Uri.parse(baseUrl + Apis.upiUpdate),
          body: jsonEncode({"customerId": customerId, "upiId": data['upiId'],"id": id}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": accessToken.toString()
          });


      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        CommonApiResponseModel commonApiResponseModel =
        CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          Flushbar(
            title: "Success!",
            message: "Upi details updated ...",
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
      Flushbar(
        title: "Error!",
        message: "Something went wrong",
        duration: Duration(seconds: 2),
      )..show(Get.context!);
    } finally {
      isLoading(false);
    }
  }
  // add upi

  addUpiAccount(Map<String, dynamic> data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);


      print(data['upiId']);



      print("data json for upi  $data");

      isLoading(true);
      var response = await http.post(Uri.parse(baseUrl + Apis.upiAdd),
          body: jsonEncode({"customerId": customerId, "upiId": data['upiId']}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
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
      Flushbar(
        title: "Error!",
        message: "Something went wrong",
        duration: Duration(seconds: 2),
      )..show(Get.context!);
    } finally {
      isLoading(false);
    }
  }
  // validate textfield
  bool validateValue(String value) {
    if (value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  final upiAddEnable = false.obs;
}
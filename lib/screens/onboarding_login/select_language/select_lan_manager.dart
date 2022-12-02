import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/model/common_model.dart';
import '../../../core/data/remote/api_constant.dart';

class SelectLanManager extends GetxController {
  var isLoading = false.obs;

  SharedPreferences? prefs;

  // updateLanApi

  void updateLan(String lnType) async {
    try {
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
      var response = await http.put(Uri.parse(baseUrl + Apis.updateLan),
          body: jsonEncode(
              {"customerId": customerId, "preferredLanguage": lnType}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("send tokens${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          const snackBar = SnackBar(
            content: Text('Language updated!'),
          );

          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        } else {}
      } else {}
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}

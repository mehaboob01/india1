import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:india_one/core/data/model/common_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/api_constant.dart';
import '../../loyality_points/cashback_redeem/cb_manager.dart';

class UpdateBankAccount extends GetxController {
  var isLoading = false.obs;
  //CashBackManager cashBackManager = Get.put(CashBackManager());

  callUpdateBankAccount(Map<String, dynamic> data, String? bankId, String? id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

      print("data json========>>> $data");

      isLoading(true);
      var response = await http.put(Uri.parse(baseUrl + Apis.updateBank),
          body: jsonEncode(


              {
                "customerId": customerId,
                "bankAccount": {
                  "id" : id,
                  "bankId": bankId,
                  "accountNumber": data['accountNumber'],
                  "ifscCode": data['ifscCode'],
                  "accountType": data['accountType']
                }
              }



          ),
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
            message: "Bank details updated ...",
            duration: Duration(seconds: 2),
          )..show(Get.context!).then((value) {

            Get.back();});

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
}

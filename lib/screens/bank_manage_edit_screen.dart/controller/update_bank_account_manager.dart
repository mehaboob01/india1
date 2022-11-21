import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/api_constant.dart';

class UpdateBankAccount extends GetxController {
  var isLoading = false.obs;




  callUpdateBankAccount(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);

    print("data json $data");

      isLoading(true);
      var response = await http.put(Uri.parse(baseUrl + Apis.updateBank),
          body: jsonEncode({
            "customerId": customerId,
            "bankAccount" : data

          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("Response ${response.body}");


      if(response.statusCode == 200 || response.statusCode == 201) {
        print("http response");
        var jsonData = jsonDecode(response.body);

        //   if (loyaltyDashboardModel.status!.code == 2000) {
        //
        //
        //
        //
        //     isLoading(false);
        //   } else {
        //     Flushbar(
        //       title: "Alert!",
        //       message: loyaltyDashboardModel.status!.message,
        //       duration: Duration(seconds: 2),
        //     )..show(Get.context!);
        //   }
        // }
        // else{
        //
        //   Flushbar(
        //     title: "Server Error!",
        //     message:"Please try after again ...",
        //     duration: Duration(seconds: 2),
        //   )..show(Get.context!);
        //
        //
        // }
        //
        // } catch (e) {
        //   Flushbar(
        //     title: "Error!",
        //     message: "Something went wrong",
        //     duration: Duration(seconds: 2),
        //   )..show(Get.context!);
        // } finally {
        //   isLoading(false);
        // }
      }}}

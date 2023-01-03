import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:india_one/core/data/model/common_model.dart';
import 'package:india_one/screens/refer/contacts_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import '../../core/data/remote/api_constant.dart';

class ReferManager extends GetxController {
  var isLoading = false.obs;
  // var getSuccess = false.obs;
  ContactCont cont = Get.put(ContactCont());
  callReferApi(String number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    String? accessToken = prefs.getString(SPKeys.ACCESS_TOKEN);

    print("mobile number ${number.substring(number.length - 10)}");
    try {
      isLoading.value = true;

      var response = await http.post(Uri.parse(baseUrl + Apis.referApp),
          body: jsonEncode({
            "customerId": customerId,
            "numberForReferral": number.substring(number.length - 10)
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
            //"Authorization": accessToken.toString()
          });

      print("response of send otp${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          //  getSuccess.value = true;

          Flushbar(
            title: "Success:)",
            message: "Invitation sent successfully!",
            duration: Duration(seconds: 2),
          )..show(Get.context!);
          cont.contactsLenght.value = cont.contacts.length;
          cont.filteredList.value = cont.contacts;

          // cont.filteredList.value.clear();
          // cont.filteredList.value = cont.contacts;
          //
          //
          // cont.contactsLenght.value = cont.contacts.length;

        } else {
          cont.contactsLenght.value = cont.contacts.length;
          cont.filteredList.value = cont.contacts;
          Flushbar(
            title: "Alert!",
            message: commonApiResponseModel.status!.message.toString(),
            duration: Duration(seconds: 3),
          )..show(Get.context!);
        }
      } else {
        cont.contactsLenght.value = cont.contacts.length;
        print("Success");
        Flushbar(
          title: "Server Error!",
          message: "Please try after sometime ...",
          duration: Duration(seconds: 1),
        )..show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        title: "Server Error!",
        message: "Please try after sometime ...",
        duration: Duration(seconds: 1),
      )..show(Get.context!);
    } finally {
      cont.contactsLenght.value = cont.contacts.length;

      isLoading.value = false;
      //     getSuccess.value = false;

    }
  }
}

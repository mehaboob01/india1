import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:india_one/core/data/model/common_model.dart';
import 'package:india_one/screens/refer/contacts_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import '../../core/data/remote/api_constant.dart';

class ReferManager extends GetxController {
  var isLoading = false.obs;
  var invitedList = [].obs;

  ContactCont cont = Get.put(ContactCont());
  Future<void> callReferApi(String number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    String? accessToken = prefs.getString(SPKeys.ACCESS_TOKEN);


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
            "x-digital-api-key": "1234",
            "Authorization": "Bearer " + accessToken.toString()
          });


      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {

          Fluttertoast.showToast(
            msg: "Invitation sent successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
          invitedList.value.add(number
              .toString()
              .replaceAll(' ', '')
              .replaceAll('-', '')
              .replaceAll('(', '')
              .replaceAll(')', ''));
          cont.contactsLenght.value = cont.contacts.length;
          cont.filteredList.value = cont.contacts;



        } else {
          cont.contactsLenght.value = cont.contacts.length;
          cont.filteredList.value = cont.contacts;

          Fluttertoast.showToast(
            msg: commonApiResponseModel.status!.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      } else {
        cont.contactsLenght.value = cont.contacts.length;

        Fluttertoast.showToast(
          msg: "Try again ...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "server error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      cont.contactsLenght.value = cont.contacts.length;

      isLoading.value = false;
      //     getSuccess.value = false;

    }
  }
}

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/api_constant.dart';
import 'cb_models/bank_list_model.dart';
import 'cb_models/customer_banks_model.dart';
import 'cb_models/upi_verify_model.dart';

class CashBackManager extends GetxController {
  var isLoading = false.obs;

  //bank list for drop dowm
  var bankList = <String>[].obs;
  var bankListSend = <String>[];

  var bankListId = <Bank>[].obs;
  var bankListIdSend = <Bank>[];
  var addAccountDetails = false.obs;
  RxMap<String, dynamic> addBankData = <String, dynamic>{}.obs;
// bank list for customer banks
  var customerBankList = <Account>[].obs;
  var customerBankListSend = <Account>[].obs;
  RxMap<String, dynamic> getAccountCardData = <String, dynamic>{}.obs;

  RxInt selectedIndex = (-1).obs;
  var selectedplanList = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    callBankListApi();
    fetchCustomerBankAccounts();
  }

  // Bank list for drop down
  callBankListApi() async {
    try {
      var response = await http.get(Uri.parse(baseUrl + Apis.banks), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "x-digital-api-key": "1234"
      });
      var jsonData = jsonDecode(response.body);

      BankListModel bankListModel = BankListModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        bankList.clear();
        bankListId.clear();
        for (var index in bankListModel.data!.banks!) {
          bankListSend.add(index.name.toString());
          bankListIdSend.add(index);
        }

        bankList.addAll(bankListSend);
        bankListId.addAll(bankListIdSend);
        isLoading(false);
      } else {
        Flushbar(
          title: "Error!",
          message: "Something went wrong",
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

  // fetch customer bank accounts

  fetchCustomerBankAccounts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);

      print("customer id${customerId}");

      var response = await http.post(
          Uri.parse(baseUrl + Apis.fetchCustomerBankAccounts),
          body: jsonEncode({"customerId": customerId}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });
      var jsonData = jsonDecode(response.body);

      FetchCustomerBanksModel fetchCustomerBanksModel =
          FetchCustomerBanksModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        List<bool> localSelectedList = [];

        customerBankList.clear();
        for (var index in fetchCustomerBanksModel.data!.accounts!) {
          customerBankListSend.add(index);
          localSelectedList.add(false);
        }

        customerBankList.addAll(customerBankListSend);
        selectedplanList.addAll(localSelectedList);

        isLoading(false);
      } else {
        Flushbar(
          title: "Error!",
          message: "Not Verified",
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
      isLoading.value = false;
    }
  }

  // cashbackToBank Api
  cashBackToBankApi(
    bool? fromAccountList,
    String? bankIdOrBankAccountId,
    Map<String, dynamic> data,
    String pointsToReedem,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      print("customer id${customerId}");

      Map<String, dynamic> sendData = {};
      if (fromAccountList == true) {
        sendData = {
          "bankId": fromAccountList == true ? "" : bankIdOrBankAccountId,
          "pointsToRedeem": data['pointsToRedeem'].toString(),
          "accountNumber": data['accountNumber'].toString(),
          "bankAccountId": fromAccountList == true ? bankIdOrBankAccountId : "",
          "ifscCode": fromAccountList == true
              ? data['IFSC'].toString()
              : data['ifscCode'].toString(),
          "accountType": fromAccountList == true
              ? data['type'].toString()
              : data['accountType'].toString(),
          "customerId": customerId,
          "saveBankDetails": true
        };
      } else {
        sendData = {
          "pointsToRedeem": pointsToReedem,
          "bankAccountId": int.parse(bankIdOrBankAccountId.toString()),
          "customerId": customerId,
        };
      }

      //  print("points redeemed==>>");
      // print(data['pointsToRedeem']);
      // print(data['accountNumber']);
      // print(data['ifscCode']);
      // print(data['accountType']);

      isLoading.value = true;
      var response = await http.post(Uri.parse(baseUrl + Apis.cashBackToBank),
          body: jsonEncode(sendData),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      if (response.statusCode == 200) {
        Flushbar(
          title: "Success!",
          message: "Cashback send in bank account!",
          duration: Duration(seconds: 2),
        )..show(Get.context!);
      } else {
        Flushbar(
          title: "Error!",
          message: "Something went wrong",
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
      isLoading.value = false;
    }
  }

  // upi verify

  upiVerifyApi(upiId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      isLoading.value = true;

      var response = await http.post(Uri.parse(baseUrl + Apis.upiVerify),
          body: jsonEncode({"upiId": upiId, "customerId": customerId}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });
      var jsonData = jsonDecode(response.body);

      UpiVerifyModel upiVerifyModel = UpiVerifyModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        if (upiVerifyModel.data!.verified == true) {
          Flushbar(
            title: "Success!",
            message: "Upi Verified!",
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Error!",
          message: "Not Verified",
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
      isLoading.value = false;
    }
  }

  // cashbackToUpi Api
  cashBackToUpiApi(String Upi, String points) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      isLoading.value = true;
      var response = await http.post(Uri.parse(baseUrl + Apis.cashBackToUpi),
          body: jsonEncode({
            "pointsToRedeem": points,
            "upiId": Upi,
            "customerId": customerId
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      if (response.statusCode == 200) {
        Flushbar(
          title: "Success!",
          message: "Cashback send in Upi!",
          duration: Duration(seconds: 2),
        )..show(Get.context!);
      } else {
        Flushbar(
          title: "Error!",
          message: "Something went wrong",
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
      isLoading.value = false;
    }
  }
}
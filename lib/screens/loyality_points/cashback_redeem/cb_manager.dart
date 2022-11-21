import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/routes.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/model/common_model.dart';
import '../../../core/data/remote/api_constant.dart';
import 'cb_models/bank_list_model.dart';
import 'cb_models/customer_banks_model.dart';
import 'cb_models/customer_upi_model.dart';

class CashBackManager extends GetxController {
  var isLoading = false.obs;
  var cardTapped = false.obs;
  var cardUpiTapped = false.obs;

  //bank list for drop dowm
  final bankList = <String>[].obs;

  var bankListSend = <String>[];

  var bankListId = <Bank>[].obs;
  var bankListIdSend = <Bank>[];
  var addAccountDetails = false.obs;
  RxMap<String, dynamic> addBankData = <String, dynamic>{}.obs;
  RxMap<String, dynamic> addUpiData = <String, dynamic>{}.obs;
// bank list for customer banks
  var customerBankList = <Account>[].obs;
  final editUpformKey = GlobalKey<FormBuilderState>();
  final editaccountformKey = GlobalKey<FormBuilderState>();
  var customerBankListSend = <Account>[].obs;

  // bank list for customer UPI'S
  var customerUPIList = <UpiId>[].obs;
  var customerUPIListSend = <UpiId>[].obs;

  RxInt selectedIndex = (-1).obs;
  RxInt selectedUpiIndex = (-1).obs;
  var selectedplanList = <bool>[].obs; // for bank
  var selectedplanUpiList = <bool>[].obs; // for upi

  @override
  void onInit() {
    super.onInit();
    customerBankList.clear();
    callBankListApi();
    fetchCustomerBankAccounts();
    fetchCustomerUpiAccounts();
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
      print("response of bank lists${response.body}");

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
        // print("asdf");
        // print(bankList.value);
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

      print("response==> ${response.body.toString()}");
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

  // fetch upi's  accounts

  fetchCustomerUpiAccounts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      var response = await http.post(
          Uri.parse(baseUrl + Apis.fetchCustomerUpiAccounts),
          body: jsonEncode({"customerId": customerId}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });
      var jsonData = jsonDecode(response.body);

      FetchCustomerUpiModel fetchCustomerUpiModel =
          FetchCustomerUpiModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        List<bool> localSelectedList = [];
        customerUPIList.clear();
        for (var index in fetchCustomerUpiModel.data!.upiIds!) {
          customerUPIListSend.add(index);
          localSelectedList.add(false);
        }

        customerUPIList.addAll(customerUPIListSend);
        selectedplanUpiList.addAll(localSelectedList);
        print("upi list${customerUPIList.length} ");

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
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      print("customer id==> ${customerId}");
      print("data tab ==>  ${data}");
      print("from list ==>  ${fromAccountList}");
      print("points to redeem ==>  ${pointsToReedem}");
      print("bank account id ==>  ${bankIdOrBankAccountId}");

      String? accountType = data['accountType'].toString() == "Saving account"
          ? "savings"
          : "current";
      print("account type ==> ${accountType}");

      Map<String, dynamic> sendData = {};
      if (fromAccountList != true) {
        print("from custom data");
        sendData = {
          "bankId": bankIdOrBankAccountId,
          "pointsToRedeem": data['pointsToRedeem'],
          "accountNumber": data['accountNumber'].toString(),
          // "bankAccountId":  "",
          "ifscCode": data['ifscCode'].toString(),
          "accountType": accountType,
          "customerId": customerId,
          "saveBankDetails": true
        };
      } else {
        print("from list data");
        sendData = {
          "pointsToRedeem": int.parse(pointsToReedem),
          "bankAccountId": bankIdOrBankAccountId,
          "customerId": customerId,
        };
      }

      print("map data for bank ${sendData.toString()}");

      isLoading.value = true;
      var response = await http.post(Uri.parse(baseUrl + Apis.cashBackToBank),
          body: jsonEncode(sendData),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });
      print("Response of points to bank api");
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);
        if (commonApiResponseModel.status!.code == 2000) {
          Flushbar(
            title: "successful!",
            message: "Cashback sent in bank account !!",
            duration: Duration(seconds: 2),
          )..show(Get.context!)
              .then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
                  MRouter.homeScreen, (Route<dynamic> route) => false))
              .then((value) => selectedIndex.value == -1);
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
          message: "Server Error ..",
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
  addUpiyApi(String upiId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      isLoading.value = true;

      var response = await http.post(Uri.parse(baseUrl + Apis.upiAdd),
          body: jsonEncode({"upiId": upiId, "customerId": customerId}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("Response of add upi${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          Flushbar(
            title: "Upi Added!",
            message: "upi added successfully ...",
            duration: Duration(seconds: 3),
          )..show(Get.context!);
          fetchCustomerUpiAccounts();
        } else {
          Flushbar(
            title: "Something went wrong ..",
            message: commonApiResponseModel.status!.message.toString(),
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Server Error!",
          message: "Please try again ...",
          duration: Duration(seconds: 2),
        )..show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        title: "Server Error!",
        message: "Please try again ...",
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
        // customerBankList.clear();

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

  // del bank account
  delBankAccount(String? id) async {
    isLoading(true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      print("customer id${customerId}");
      print("bankAccountId${id}");

      var response = await http.delete(
          Uri.parse(baseUrl + Apis.deleteCustomerBankAccount),
          body: jsonEncode({"customerId": customerId, "bankAccountId": id}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("response delete==> ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          isLoading(false);
          Flushbar(
            title: "Success!!",
            message: "bank del Successfully ..",
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        } else {
          isLoading(false);
          Flushbar(
            title: "Error!!",
            message: commonApiResponseModel.status!.message,
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        isLoading(false);
        Flushbar(
          title: "Error!!",
          message: "Server Error ...",
          duration: Duration(seconds: 2),
        )..show(Get.context!).then((value) => () {
              customerBankList.clear();
              fetchCustomerBankAccounts();
            });
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

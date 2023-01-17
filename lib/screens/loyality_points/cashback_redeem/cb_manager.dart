import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/routes.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/model/common_model.dart';
import '../../../core/data/remote/api_constant.dart';
import '../../../core/data/remote/dio_api_call.dart';
import 'cb_models/bank_list_model.dart';
import 'cb_models/customer_banks_model.dart';
import 'cb_models/customer_upi_model.dart';

class CashBackManager extends GetxController {
  var isLoading = false.obs;
  var cardTapped = false.obs;
  var cardUpiTapped = false.obs;

  //bank list for drop dowm
  var bankList = <String>[].obs;
  var bankListSend = <String>[];

  var bankListId = <Banks>[].obs;
  var bankListIdSend = <Banks>[];
  final bankNameFormKey = GlobalKey<FormState>();
  final dropDownBankName = ''.obs;
  final accountTextObscure = false.obs; // bank account isObscure bool
  final comfirmAccountObscure =
      false.obs; // bank comfirm account number isObscure bool
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
    customerBankListSend.clear();
    customerUPIList.clear();
    customerUPIListSend.clear();
    // bankList.clear();
    // bankListIdSend.clear();
    // callBankListApi();
    fetchCustomerBankAccounts();
    fetchCustomerUpiAccounts();
  }

  // Bank list for drop down
  callBankListApi() async {
    bankList.clear();
    bankListSend.clear();
    bankListId.clear();
    bankListIdSend.clear();
    try {
      var response = await DioApiCall()
          .commonApiCall(endpoint: Apis.banks, method: Type.GET);

      if (response != null) {
        BankListModel bankListModel = BankListModel.fromJson(response);
        bankList.clear();
        bankListId.clear();
        for (var index in bankListModel.banks!) {
          bankListSend.add(index.name.toString());
          bankListIdSend.add(index);
        }

        bankList.addAll(bankListSend);
        bankListId.addAll(bankListIdSend);

        isLoading(false);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  // fetch customer bank accounts

  fetchCustomerBankAccounts() async {
    customerBankList.clear();
    customerBankListSend.clear();

    // for profile

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

      print("customer id${customerId}");

      var response = await http.post(
          Uri.parse(baseUrl + Apis.fetchCustomerBankAccounts),
          body: jsonEncode({"customerId": customerId}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer " + accessToken.toString()
          });

      print("response==> ${response.body.toString()}");
      var jsonData = jsonDecode(response.body);

      FetchCustomerBanksModel fetchCustomerBanksModel =
          FetchCustomerBanksModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        List<bool> localSelectedList = [];

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
    customerUPIList.clear();
    customerUPIListSend.clear();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
      var response = await http.post(
          Uri.parse(baseUrl + Apis.fetchCustomerUpiAccounts),
          body: jsonEncode({"customerId": customerId}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer " + accessToken.toString()
          });
      var jsonData = jsonDecode(response.body);

      FetchCustomerUpiModel fetchCustomerUpiModel =
          FetchCustomerUpiModel.fromJson(jsonData);

      if (response.statusCode == 200) {
        List<bool> localSelectedList = [];
        customerUPIList.clear();
        customerUPIListSend.clear();
        for (var index in fetchCustomerUpiModel.data!.upiIds!) {
          customerUPIListSend.add(index);
          localSelectedList.add(false);
        }

        customerUPIList.addAll(customerUPIListSend);
        selectedplanUpiList.addAll(localSelectedList);
        print("upi list :: ${customerUPIList.length} ");

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
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

      String? accountType = data['accountType'].toString() == "Saving account"
          ? "savings"
          : "current";

      Map<String, dynamic> sendData = {};
      if (fromAccountList != true) {
        print("from custom data");
        sendData = {
          "bankId": bankIdOrBankAccountId,
          "pointsToRedeem": pointsToReedem,
          "accountNumber": data['accountNumber'].toString(),
          "bankAccountId": "",
          "ifscCode": data['ifscCode'].toString(),
          "accountType": accountType,
          "customerId": customerId,
          "saveBankDetails": true
        };
        print(sendData);
      } else {
        print("from list data");
        sendData = {
          "pointsToRedeem": pointsToReedem,
          "bankAccountId": bankIdOrBankAccountId,
          "customerId": customerId,
        };
      }

      isLoading.value = true;
      var response = await http.post(Uri.parse(baseUrl + Apis.cashBackToBank),
          body: jsonEncode(sendData),
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
            msg: "cashback sent  successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          )
              .then((value) => Get.toNamed(MRouter.verifiedScreen))
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
      isLoading(true);

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.upiAdd,
        method: Type.POST,
        data: jsonEncode({"upiId": upiId, "customerId": customerId}),
      );

      if (response != null) {
        Fluttertoast.showToast(
          msg: "upi added successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );

        await fetchCustomerUpiAccounts();
        isLoading(false);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  // cashbackToUpi Api
  cashBackToUpiApi(String Upi, String points, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
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
            'x-digital-api-key': '1234',
            "Authorization": "Bearer " + accessToken.toString()
          });

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "cashback sent  successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        )
            .then((value) => Get.toNamed(MRouter.verifiedScreen))
            .then((value) => selectedUpiIndex.value == -1);
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
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

      var response = await http.delete(
          Uri.parse(baseUrl + Apis.deleteCustomerBankAccount),
          body: jsonEncode({"customerId": customerId, "bankAccountId": id}),
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
          isLoading(false);

          await fetchCustomerBankAccounts();
          Get.back();
          Flushbar(
            title: "Success!!",
            message: "bank deleted Successfully ..",
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

  // del bank account
  delUpiAccount(String? id) async {
    isLoading(true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs!.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

      var response = await http.delete(
          Uri.parse(baseUrl + Apis.deleteCustomerUpiAccount),
          body: jsonEncode({"customerId": customerId, "customerUpiId": id}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer " + accessToken.toString()
          });

      print("response delete==> ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          isLoading(false);
          await fetchCustomerUpiAccounts();
          Get.back();
          Flushbar(
            title: "Success!!",
            message: "Upi deleted Successfully ..",
            duration: Duration(seconds: 2),
          )..show(Get.context!).then((value) => Get.back());
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

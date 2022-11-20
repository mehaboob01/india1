import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/screens/profile/model/bank_details_model.dart';
import 'package:india_one/screens/profile/model/profile_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/local/shared_preference_keys.dart';
import '../model/upi_id_model.dart';

class ProfileController extends GetxController {
  RxBool addPersonalLoading = false.obs,
      addResidentialLoading = false.obs,
      addOccupationLoading = false.obs,
      getProfileLoading = true.obs,
      getPinCodeLoading = false.obs,
      getBankAccountLoading = false.obs,
      getUpiIdLoading = false.obs,
      autoValidation = false.obs;
  RxInt currentStep = 1.obs;
  RxBool complete = false.obs;
  List<String> titleList = [
    "Personal",
    "Residential",
    "Occupation",
  ];

  Rx<PageController>? pageSelection;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController = TextEditingController().obs;
  Rx<TextEditingController> alternateNumberController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> addressLine1Controller = TextEditingController().obs;
  Rx<TextEditingController> addressLine2Controller = TextEditingController().obs;
  Rx<TextEditingController> pincodeController = TextEditingController().obs;
  Rx<TextEditingController> occupationController = TextEditingController().obs;
  Rx<TextEditingController> monthlyIncomeController = TextEditingController().obs;
  Rx<TextEditingController> panNumberController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  RxString maritalStatus = ''.obs, employmentType = ''.obs, city = ''.obs, state = ''.obs, gender = ''.obs, customerId = ''.obs, accountType = ''.obs, vehicleType = ''.obs;

  Rx<TextEditingController> bankNameController = TextEditingController().obs;
  Rx<TextEditingController> accountNumberController = TextEditingController().obs;
  Rx<TextEditingController> ifscController = TextEditingController().obs;

  Rx<ProfileDetailsModel> profileDetailsModel = ProfileDetailsModel().obs;
  late SharedPreferences prefs;

  Rx<BankDetailsModel> bankDetailsModel = BankDetailsModel().obs;
  Rx<UpiIdModel> upiIdModel = UpiIdModel().obs;

  resetData() {
    firstNameController.value.text = '';
    lastNameController.value.text = '';
    mobileNumberController.value.text = '';
    alternateNumberController.value.text = '';
    emailController.value.text = '';
    addressLine1Controller.value.text = '';
    addressLine2Controller.value.text = '';
    pincodeController.value.text = '';
    occupationController.value.text = '';
    monthlyIncomeController.value.text = '';
    panNumberController.value.text = '';
    dobController.value.text = '';
    bankNameController.value.text = '';
    accountNumberController.value.text = '';
    ifscController.value.text = '';
    maritalStatus.value = '';
    employmentType.value = '';
    city.value = '';
    state.value = '';
    gender.value = '';
    customerId.value = '';
    accountType.value = '';
    vehicleType.value = '';
  }

  setData() {
    firstNameController.value.text = profileDetailsModel.value.firstName ?? '';
    lastNameController.value.text = profileDetailsModel.value.lastName ?? '';
    mobileNumberController.value.text = profileDetailsModel.value.mobileNumber ?? '';
    alternateNumberController.value.text = profileDetailsModel.value.alternateNumber ?? '';
    emailController.value.text = profileDetailsModel.value.email ?? '';
    dobController.value.text = profileDetailsModel.value.dateOfBirth ?? '';
    gender.value = profileDetailsModel.value.gender ?? '';
    maritalStatus.value = profileDetailsModel.value.maritalStatus ?? '';

    addressLine1Controller.value.text = profileDetailsModel.value.address?.addressLine1 ?? '';
    addressLine2Controller.value.text = profileDetailsModel.value.address?.addressLine2 ?? '';
    pincodeController.value.text = profileDetailsModel.value.address?.postCode ?? '';
    city.value = profileDetailsModel.value.address?.city ?? '';
    state.value = profileDetailsModel.value.address?.state ?? '';

    employmentType.value = profileDetailsModel.value.employmentType ?? '';
    occupationController.value.text = profileDetailsModel.value.occupation ?? '';
    monthlyIncomeController.value.text = "${profileDetailsModel.value.income}";
    panNumberController.value.text = profileDetailsModel.value.panNumber ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    getId();
    pageSelection?.value = PageController(initialPage: currentStep.value - 1);
    Future.delayed(Duration(seconds: 2), () {
      getProfileData();
      getBankDetails();
      getUpiIdDetails();
    });
  }

  getId() async {
    prefs = await SharedPreferences.getInstance();
    customerId.value = prefs.getString(SPKeys.CUSTOMER_ID) ?? '';
    return customerId.value;
  }

  next() {
    if (currentStep <= titleList.length) {
      goTo(currentStep.value + 1);
    }
  }

  back() {
    if (currentStep > 1) {
      goTo(currentStep.value - 1);
    }
  }

  goTo(int step) {
    currentStep.value = step;
    if (currentStep > titleList.length) {
      complete.value = true;
    }
  }

  nameValidation(value, message) {
    if (value.toString().trim().length < 3) {
      return message;
    }
    return null;
  }

  accountNumberValidation(value) {
    String pattern = r'(^[0-9]{9,18}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length < 9) {
      return 'Please enter valid account number of 9 digit';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid account number';
    }
    return null;
  }

  ifscValidation(value) {
    String pattern = r'(^[A-Z]{4}0[A-Z0-9]{6}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length < 8) {
      return 'Please enter valid ifsc code';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid ifsc code';
    }
    return null;
  }

  mobileValidation(value) {
    String pattern = r'(^[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  emailValidation(value) {
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  nullCheckValidation(value, message) {
    if (value == '' || value == null) {
      return message;
    }
    return null;
  }

  pinCodeValidation(value) {
    if (value.toString().trim().length < 6) {
      return 'Enter valid pin code';
    }
    return null;
  }

  panValidation(value) {
    String pattern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid pan number';
    else
      return null;
  }

  Future addPersonalDetails({bool? isFromLoan = false, Function? callBack, String? loanApplicationId}) async {
    addPersonalLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.addPersonalDetails,
        method: Type.PUT,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            if (loanApplicationId != null || loanApplicationId != '') ...{
              "loanApplicationId": loanApplicationId,
            },
            "customerDetails": {
              "firstName": "${firstNameController.value.text}",
              "lastName": "${lastNameController.value.text}",
              "mobileNumber": "${mobileNumberController.value.text}",
              "dateOfBirth": "${dobController.value.text}",
              "preferredLanguage": "EN",
              "email": "${emailController.value.text}",
              "gender": "${gender.value}",
              "maritalStatus": "${maritalStatus.value}"
            }
          },
        ),
      );
      if (response != null) {
        if (isFromLoan == true || loanApplicationId != null) {
          callBack!();
        } else {
          Get.back();
        }
        getProfileData();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addPersonalLoading.value = false;
    }
  }

  Future addResidentialDetails({bool? isFromLoan = false, Function? callBack, String? loanApplicationId}) async {
    addResidentialLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.residentialAddress,
        method: Type.PUT,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            if (loanApplicationId != null || loanApplicationId != '') ...{
              "loanApplicationId": loanApplicationId,
            },
            "customerDetails": {
              "address": {
                "addressLine1": "${addressLine1Controller.value.text}",
                "addressLine2": "${addressLine2Controller.value.text}",
                "postCode": "${pincodeController.value.text}",
                "city": "${city.value}",
                "state": "${state.value}"
              }
            }
          },
        ),
      );
      if (response != null) {
        if (isFromLoan == true || loanApplicationId != null) {
          callBack!();
        } else {
          Get.back();
        }
        getProfileData();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addResidentialLoading.value = false;
    }
  }

  Future addOccupationDetails({bool? isFromLoan = false, Function? callBack, String? loanApplicationId}) async {
    addOccupationLoading.value = true;
    print(employmentType.value);
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.additionalDetails,
        method: Type.PUT,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            if (loanApplicationId != null) ...{
              "loanApplicationId": loanApplicationId,
            },
            "customerDetails": {
              "panNumber": "${panNumberController.value.text}",
              "occupation": "${occupationController.value.text}",
              "income": "${monthlyIncomeController.value.text}",
              "preferredLanguage": "EN",
              "employmentType": "${employmentType.value}",
            }
          },
        ),
      );
      if (response != null) {
        if (isFromLoan == true || loanApplicationId != null || loanApplicationId != '') {
          callBack!();
        } else {
          Get.back();
        }
        getProfileData();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addOccupationLoading.value = false;
    }
  }

  Future getProfileData() async {
    try {
      getProfileLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.profile,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
          },
        ),
      );
      if (response != null) {
        profileDetailsModel.value = ProfileDetailsModel.fromJson(response);
        setData();
      }
    } catch (exception) {
      print(exception);
    } finally {
      getProfileLoading.value = false;
    }
  }

  Future getCityState(value) async {
    getPinCodeLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.getCityState + "?postCode=$value",
        method: Type.GET,
      );
      if (response != null) {
        city.value = response['city'];
        state.value = response['state'];
      } else {
        Fluttertoast.showToast(
          msg: "Enter valid pincode.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (exception) {
      Fluttertoast.showToast(
        msg: "$exception",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      getPinCodeLoading.value = false;
    }
  }

  Future getBankDetails() async {
    getBankAccountLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.getBankAccount,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
          },
        ),
      );
      if (response != null) {
        bankDetailsModel.value = BankDetailsModel.fromJson(response);
      } else {
        Fluttertoast.showToast(
          msg: "couldn't get bank account details.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (exception) {
      Fluttertoast.showToast(
        msg: "$exception",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      getBankAccountLoading.value = false;
    }
  }

  Future getUpiIdDetails() async {
    getUpiIdLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.getUpiIds,
        method: Type.POST,
      );
      if (response != null) {
        upiIdModel.value = UpiIdModel.fromJson(response);
      } else {
        Fluttertoast.showToast(
          msg: "couldn't get upi id details.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (exception) {
      Fluttertoast.showToast(
        msg: "$exception",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      getUpiIdLoading.value = false;
    }
  }

  Future addBankAccountData() async {
    try {
      getBankAccountLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.addBankAccount,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
            "bankAccount": {
              "accountNumber": "${accountNumberController.value.text}",
              "ifscCode": "${ifscController.value.text}",
              "accountType": "${accountType.value}",
            }
          },
        ),
      );
      if (response != null) {
        if (response['account'] != null) {
          getBankDetails();
          Get.back();
        }
      }
    } catch (exception) {
      print(exception);
    } finally {
      getBankAccountLoading.value = false;
    }
  }
}

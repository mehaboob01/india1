import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';

import '../personal_loan_io/personal_loan.dart';

class LoanController extends GetxController {
  RxBool createLoanLoading = false.obs;
  Rx<double> sliderValue = 100000.0.obs;
  Rx<double> minValue = 0.0.obs;
  Rx<double> maxValue = 0.0.obs;
  RxString customerId = ''.obs;

  var currentScreen = Steps.LOAN_AMOUNT.index.obs;

  ProfileController profileController = Get.put(ProfileController());

  late CreateLoanModel createLoanModel;

  List<String> titleList = [
    "Loan amount",
    "Personal",
    "Residential",
    "Occupation",
  ];
  List<String> bikeLoanTitleList = [
    "Loan amount",
    "Personal",
    "Residential",
  ];

  void updateScreen(screenIndex) {
    currentScreen.value = screenIndex;
  }

  Future createLoanApplication({
    required LoanType loanType,
  }) async {
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.createLoanApplication,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
            "loanType": "$loanType",
          },
        ),
      );
      if (response != null) {
        createLoanModel = CreateLoanModel.fromJson(response);
        maxValue.value = double.tryParse((createLoanModel.loanConfiguration?.maxLoanAmount ?? 0).toString()) ?? 0;
        print(createLoanModel.loanType);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }

  Future updateLoanAmount({required String amount}) async {
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.updateAmountLoan,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
            "loanApplicationId": "${createLoanModel.loanApplicationId}",
            "loanAmount" : "$amount"
          },
        ),
      );
      if (response != null) {
        createLoanModel = CreateLoanModel.fromJson(response);
        updateScreen(Steps.PERSONAL.index);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }
}

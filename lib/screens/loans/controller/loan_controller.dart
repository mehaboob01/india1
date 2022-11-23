import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/screens/Pages/recent_transaction_model.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/loans/model/farm_loan_product_model.dart';
import 'package:india_one/screens/loans/model/farm_loan_requirment_model.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/screens/loans/model/loan_providers_model.dart';
import 'package:india_one/screens/loans/submission_page.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';

import '../personal_loan_io/personal_loan.dart';

class LoanController extends GetxController {
  RxBool createLoanLoading = false.obs;
  RxBool farmLoanProductLoading = false.obs;
  Rx<double> sliderValue = 100000.0.obs;
  Rx<double> minValue = 0.0.obs;
  Rx<double> maxValue = 0.0.obs;
  RxString customerId = ''.obs;

  var currentScreen = Steps.LOAN_AMOUNT.index.obs;

  ProfileController profileController = Get.put(ProfileController());

  Rx<CreateLoanModel> createLoanModel = CreateLoanModel().obs;
  Rx<LoanLendersModel> loanLendersModel = LoanLendersModel().obs;
  Rx<LoanProvidersModel> loanProvidersModel = LoanProvidersModel().obs;
  Rx<FarmLoanProductModel> farmLoanProductModel = FarmLoanProductModel().obs;
  RxInt farmCompletedIndex = 0.obs;
  Rx<RecentTransactionModel> recentTransactionModel = RecentTransactionModel().obs;

  List otherDetails = [
    {"title": "Interest rate", "value": ""},
    {"title": "Vehicle loan process", "value": ""},
    {"title": "Loan amount", "value": ""},
    {"title": "Loan tenure", "value": ""},
    {"title": "Loan interest rate", "value": ""},
  ];

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
  List<String> farmLoanTitleList = [
    "Loan details",
    "Personal",
    "Residential",
  ];

  List<FarmLoanRequirementModel> loanRequirements = [
    FarmLoanRequirementModel(
        key: "LoanAgainstTractor", name: "Loan against tractor"),
    FarmLoanRequirementModel(
        key: "TrackBasedPersonalLoan", name: "Track based personal loan"),
    FarmLoanRequirementModel(key: "ImplementFinance", name: "Implement finance")
  ];

  statusTextColor(String status) {
    if (status.toLowerCase() ==
        "pending") {
      return const Color(0xFF4F0AD2);
    } else if (status.toLowerCase() ==
        "approved") {
      return const Color(0xFF00C376);
    } else if (status.toLowerCase() ==
        "rejected") {
      return const Color(0XffED1C24);
    } else {
      return Colors.black;
    }
  }

  void updateScreen(screenIndex) {
    currentScreen.value = screenIndex;
  }

  getLoanType(LoanType loanType) {
    if (loanType == LoanType.PersonalLoan) {
      return 'Personal';
    } else if (loanType == LoanType.GoldLoan) {
      return 'Gold';
    } else if (loanType == LoanType.BikeLoan) {
      return 'TwoWheeler';
    } else if (loanType == LoanType.CarLoan) {
      return 'FourWheeler';
    } else if (loanType == LoanType.TractorLoan) {
      return 'Farm';
    } else if (loanType == LoanType.FarmLoan) {
      return 'FarmEquipment';
    }
    return '';
  }

  Future createLoanApplication({
    required LoanType loanType,
    Function? callBack,
  }) async {
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.createLoanApplication,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          "loanType": "${getLoanType(loanType)}",
        }),
      );
      if (response != null) {
        createLoanModel.value = CreateLoanModel.fromJson(response);
        maxValue.value = double.tryParse((createLoanModel.value.loanConfiguration?.maxLoanAmount ?? 0).toString()) ?? 0;
        minValue.value = double.tryParse((createLoanModel.value.loanConfiguration?.minLoanAmount ?? 0).toString()) ?? 0;
        callBack!(createLoanModel.value);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }

  Future updateLoanAmount({required String amount, LoanType? type}) async {
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.updateAmountLoan,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          "loanApplicationId": "${createLoanModel.value.loanApplicationId}",
          "loanAmount": "$amount",
          if (type == LoanType.BikeLoan) ...{
            "twoWheelerType": profileController.vehicleType.value,
          },
          if (type == LoanType.CarLoan) ...{
            "fourWheelerType": profileController.vehicleType.value,
          },
        }),
      );
      if (response != null) {
        createLoanModel.value = CreateLoanModel.fromJson(response);
        updateScreen(Steps.PERSONAL.index);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }

  Future getProviders(
      {required bool isPersonalLoan, String? providerId}) async {
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: isPersonalLoan == true ? Apis.getProviders : Apis.getLenders,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
            "loanApplicationId": "${createLoanModel.value.loanApplicationId}",
            if (providerId != null || providerId != '') ...{
              "loanProviderId": "$providerId",
            }
          },
        ),
      );
      if (response != null) {
        if (isPersonalLoan == true) {
          loanProvidersModel.value = LoanProvidersModel.fromJson(response);
        } else {
          loanLendersModel.value = LoanLendersModel.fromJson(response);
        }
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }

  Future applyLoan({
    required String providerId,
    required String lenderId,
  }) async {
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.applyLoan,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          "loanApplicationId": "${createLoanModel.value.loanApplicationId}",
          if (providerId != '') ...{
            "loanProviderId": "$providerId",
          },
          if (lenderId != '')...{
            "loanLenderId": "$lenderId",
          }

        }),
      );
      if (response != null) {
        loanProvidersModel.value = LoanProvidersModel.fromJson(response);
        Get.to(() => SubmissionPage());
        Future.delayed(Duration(seconds: 3), () {
          Get.offNamedUntil(MRouter.homeScreen, (route) => route.isFirst);
        });
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }

  Future fetchFarmLoanProducts({
    required String requirementId,
  }) async {
    try {
      farmLoanProductLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.fetchFarmProducts,
        method: Type.POST,
        data: json.encode({
          "requirementId": requirementId,
        }),
      );
      if (response != null) {
        profileController.subProduct.value = (-1);
        profileController.brand.value = (-1);
        farmLoanProductModel.value = FarmLoanProductModel.fromJson(response);
      }
    } catch (exception) {
      print(exception);
    } finally {
      farmLoanProductLoading.value = false;
    }
  }

  Future<bool> updateFarmLoanDetails() async {
    try {
      farmLoanProductLoading.value = true;
      customerId.value = await profileController.getId();

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.updateFarmLoanDetails,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          "loanApplicationId": createLoanModel.value.loanApplicationId,
          "farmLoanRequirement":
              loanRequirements[profileController.loanRequirement.value].key,
          if (farmLoanProductModel.value.subProducts != null)
            "farmSubProduct": farmLoanProductModel
                .value.subProducts![profileController.subProduct.value],
          if (farmLoanProductModel.value.brands != null)
            "farmBrand": farmLoanProductModel
                .value.brands![profileController.brand.value]
        }),
      );
      if (response != null) {
        return true;
      }else{
        return false;
      }
    } catch (exception) {
      print(exception);
      return false;
    } finally {
      farmLoanProductLoading.value = false;
    }
  }

  Future recentTransactions({LoanType? loanType}) async {
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.recentTransactionLoan,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          if (loanType != null) ...{
            "loanType": "${getLoanType(loanType)}",
          }
        }),
      );
      if (response != null) {
        recentTransactionModel.value = RecentTransactionModel.fromJson(response);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/screens/loans/model/loan_providers_model.dart';
import 'package:india_one/screens/loans/submission_page.dart';
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

  Rx<CreateLoanModel> createLoanModel = CreateLoanModel().obs;
  Rx<LoanLendersModel> loanLendersModel = LoanLendersModel().obs;
  Rx<LoanProvidersModel> loanProvidersModel = LoanProvidersModel().obs;

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

  getLoanType(LoanType loanType) {
    if (loanType == LoanType.PersonalLoan) {
      return 'Personal';
    } else if (loanType == LoanType.GoldLoan) {
      return 'Gold';
    } else if (loanType == LoanType.BikeLoan) {
      return 'Bike';
    } else if (loanType == LoanType.CarLoan) {
      return 'Car';
    } else if (loanType == LoanType.TractorLoan) {
      return 'Farm';
    } else if (loanType == LoanType.FarmLoan) {
      return 'FarmEquipment';
    }
    return '';
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
            "loanType": "${getLoanType(loanType)}",
          },
        ),
      );
      if (response != null) {
        createLoanModel.value = CreateLoanModel.fromJson(response);
        maxValue.value = double.tryParse((createLoanModel.value.loanConfiguration?.maxLoanAmount ?? 0).toString()) ?? 0;
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
        data: json.encode({
          "customerId": customerId.value,
          "loanApplicationId": "${createLoanModel.value.loanApplicationId}",
          "loanAmount": "$amount",
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

  Future getProviders({required bool isPersonalLoan,String? providerId}) async {
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
            if(providerId !=null || providerId !='')...{
              "loanProviderId" : "$providerId"
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
          "loanProviderId": "$providerId",
          "loanLenderId": "$lenderId",
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
}

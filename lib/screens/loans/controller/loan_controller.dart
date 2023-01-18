import 'dart:convert';
import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/screens/Pages/recent_transaction_model.dart';
import 'package:india_one/screens/insurances/model/insurance_recent_transaction_model.dart';
import 'package:india_one/screens/loans/bike_loan/models_model.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/loans/model/farm_loan_product_model.dart';
import 'package:india_one/screens/loans/model/farm_loan_requirment_model.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/screens/loans/model/loan_providers_model.dart';
import 'package:india_one/screens/loans/submission_page.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/local/shared_preference_keys.dart';
import '../model/loan_lender_others_model.dart';
import '../personal_loan_io/personal_loan.dart';

class LoanController extends GetxController {
  RxBool createLoanLoading = false.obs;
  RxBool lenderLoanLoading = false.obs;
  RxBool personLoanLoading = false.obs;

  var productLoading = false.obs;
  var modelLoading = false.obs;
  RxBool trackLoading = false.obs;
  RxBool farmLoanProductLoading = false.obs;
  Rx<double> sliderValue = 0.0.obs;
  Rx<double> minValue = 0.0.obs;
  Rx<double> maxValue = 0.0.obs;
  RxString customerId = ''.obs;

  // // lenders list new model
  // var lendersList = <Lende>[].obs;
  // var lendersListSend = <Details>[];

  var currentScreen = Steps.LOAN_AMOUNT.index.obs;

  ProfileController profileController = Get.put(ProfileController());

  Rx<CreateLoanModel> createLoanModel = CreateLoanModel().obs;
  Rx<LoanLendersModel> loanLendersModel = LoanLendersModel().obs;
  Rx<LoanLenderOthersModel> loanLenderOthersModel = LoanLenderOthersModel().obs;

  // Rx<NewLendersModel> newLoanLendersModel =
  //     NewLendersModel().obs; // new lenders model

  Rx<LoanProvidersModel> loanProvidersModel = LoanProvidersModel().obs;
  Rx<FarmLoanProductModel> farmLoanProductModel = FarmLoanProductModel().obs;
  Rx<TrackBasedLoanProductModel> trackLoanProductModel =
      TrackBasedLoanProductModel().obs;

  var twoWheelerMakes = [].obs;
  var twoWheelerModels = [].obs;

  RxInt farmCompletedIndex = 0.obs;

  RxInt trackCompletedIndex = 0.obs;
  Rx<RecentTransactionModel> recentTransactionModel =
      RecentTransactionModel().obs;
  Rx<InsuranceRecentTransactionModel> insuranceRecentTransactionModel =
      InsuranceRecentTransactionModel().obs;

  List otherDetails = [
    {"title": "Interest rate", "value": ""},
    {"title": "Vehicle loan process", "value": ""},
    {"title": "Loan amount", "value": ""},
    {"title": "Loan tenure", "value": ""},
    {"title": "Loan interest rate", "value": ""},
  ];

  List<String> titleList = [
    "loan_amount_header",
    "personal_header_stpr",
    "residential_header_stpr",
    "occupational_header_stpr",
    "additional_header_stpr",
  ];
  List<String> bikeLoanTitleList = [
    "loan_details_header_stpr",
    "personal_header_stpr",
    "residential_header_stpr",
  ];
  List<String> farmLoanTitleList = [
    "loan_details_header_stpr",
    "personal_header_stpr",
    "residential_header_stpr",
  ];

  List<FarmLoanRequirementModel> loanRequirements = [
    FarmLoanRequirementModel(
        key: "LoanAgainstTractor", name: "Loan against tractor"),
    // FarmLoanRequirementModel(
    //     key: "TrackBasedPersonalLoan", name: "Track based personal loan"),
    FarmLoanRequirementModel(key: "ImplementFinance", name: "Implement finance")
  ];

  List<TrackBasedLoanRequirementModel> trackBasedRequirements = [
    // TrackBasedLoanRequirementModel(
    //     key: "LoanAgainstTractor", name: "Loan against tractor"),
    TrackBasedLoanRequirementModel(
        key: "TrackBasedPersonalLoan", name: "Track based personal loan"),
    // FarmLoanRequirementModel(key: "ImplementFinance", name: "Implement finance")
  ];

  statusTextColor(String status) {
    if (status.toLowerCase() == "pending") {
      return const Color(0xFF4F0AD2);
    } else if (status.toLowerCase() == "approved") {
      return const Color(0xFF00C376);
    } else if (status.toLowerCase() == "rejected") {
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
    } else if (loanType == LoanType.TrackBasedPersonalLoan) {
      return 'TrackBasedPersonalLoan';
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
        print("response loan create applicaiton : ${response}");

        createLoanModel.value = CreateLoanModel.fromJson(response);
        minValue.value = double.tryParse(
                (createLoanModel.value.loanConfiguration?.minLoanAmount ?? 0)
                    .toString()) ??
            0;
        maxValue.value = double.tryParse(
                (createLoanModel.value.loanConfiguration?.maxLoanAmount ?? 0)
                    .toString()) ??
            0;
        sliderValue.value = double.tryParse(
                (createLoanModel.value.loanConfiguration?.minLoanAmount ?? 0)
                    .toString()) ??
            0;
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
            "twoWheelerMake": profileController.twoWheelermakes.value,
            "twoWheelerModel": profileController.twoWheelerModel.value,
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
      {required bool isPersonalLoan,
      String? providerId,
      String? fromScreen}) async {
    Map<String, dynamic> lendersData = {
      "customerId": customerId.value,
      "loanApplicationId": "${createLoanModel.value.loanApplicationId}",
      if (providerId != null || providerId != '') ...{
        "loanProviderId": "$providerId",
      }
    };

    print("providers data==>${lendersData}");
    try {
      createLoanLoading.value = true;
      lenderLoanLoading.value = true;
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
        print("RESPONSE of loan :  ${response}");
        if (isPersonalLoan == true) {
          print("in if condition");
          loanProvidersModel.value = LoanProvidersModel.fromJson(response);
        } else {
          print("in side else of personal loan ${fromScreen}");
          if (fromScreen == 'Personal') {
            loanLendersModel.value = LoanLendersModel.fromJson(response);
          } else {
            // other than personal loan will come here
            loanLenderOthersModel.value =
                LoanLenderOthersModel.fromJson(response);
          }

// NewNewLoanLendersModel

        }
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
      lenderLoanLoading.value = false;
    }
  }

  Future applyLoan({
    required String providerId,
    required String lenderId,
  }) async {
    Map<String, dynamic> sendData = {
      "customerId": customerId.value,
      "loanApplicationId": "${createLoanModel.value.loanApplicationId}",
      if (providerId != '') ...{
        "loanProviderId": "$providerId",
      },
      if (lenderId != '') ...{
        "loanLenderId": "$lenderId",
      }
    };
    print("data form loan$sendData");

    try {
      createLoanLoading.value = true;
      personLoanLoading.value = true;
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
          if (lenderId != '') ...{
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
      personLoanLoading.value = false;
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

  Future fetchTrackBasedLoanProducts({
    required String requirementId,
  }) async {
    try {
      //  farmLoanProductLoading.value = true;
      trackLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.fetcTrackBasedLoanProducts,
        method: Type.GET,
      );
      if (response != null) {
        log("OK");
        print(response);
        profileController.trackBasedsubProduct.value = (-1);
        profileController.trackBasedbrand.value = (-1);
        trackLoanProductModel.value =
            TrackBasedLoanProductModel.fromJson(response);
      }
    } catch (exception) {
      print(exception);
    } finally {
      trackLoading.value = false;
    }
  }

  Future fetch2WheelerProducts() async {
    try {
      //  farmLoanProductLoading.value = true;
      trackLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.fetchTwoWheelerMakes,
        method: Type.GET,
      );
      if (response != null) {
        print(response);
        twoWheelerMakes.value = response;
      }
    } catch (exception) {
      print(exception);
    } finally {
      trackLoading.value = false;
    }
  }

  Rx<TwoWheelerModels> twoWheelerModelsmodel = TwoWheelerModels().obs;
  Future fetch2WheelerModels() async {
    try {
      //  farmLoanProductLoading.value = true;
      trackLoading.value = true;
      var response = await DioApiCall().commonApiCall(
          endpoint: Apis.fetchTwoWheelerModels,
          method: Type.POST,
          data: json.encode({"make": profileController.twoWheelermakes.value}));
      if (response != null) {
        print(response);
        twoWheelerModelsmodel.value = TwoWheelerModels.fromJson(response);
        print(twoWheelerModelsmodel.value);
      }
    } catch (exception) {
      print(exception);
    } finally {
      trackLoading.value = false;
    }
  }

  Future<bool> updateFarmLoanDetails() async {
    FarmLoanRequirementModel model = loanRequirements.firstWhere((element) =>
        element.name == profileController.farmLoanReqCtrl.value.text);
    try {
      farmLoanProductLoading.value = true;
      customerId.value = await profileController.getId();

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.updateFarmLoanDetails,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          "loanApplicationId": createLoanModel.value.loanApplicationId,
          "farmLoanRequirement": model.key,

          // loanRequirements[profileController.loanRequirement.value].key,
          if (farmLoanProductModel.value.subProducts != null)
            "farmSubProduct": profileController.farmSubproductCtrl.value.text,
          // farmLoanProductModel
          //     .value.subProducts![profileController.subProduct.value],
          if (farmLoanProductModel.value.brands != null)
            "farmBrand": profileController.farmBrand.value.text,
          // farmLoanProductModel
          //     .value.brands![profileController.brand.value]
        }),
      );
      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      print(exception);
      return false;
    } finally {
      farmLoanProductLoading.value = false;
    }
  }

  Future<bool> updateTrackBasedLoanDetails() async {
    try {
      farmLoanProductLoading.value = true;
      customerId.value = await profileController.getId();

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.updateFarmLoanDetails,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
            "loanApplicationId": createLoanModel.value.loanApplicationId,
            "farmLoanRequirement": "TrackBasedPersonalLoan",
            if (trackLoanProductModel.value.subProducts != null)
              "farmSubProduct": profileController.trackBasedCtrl.text
            // trackLoanProductModel.value
            //     .subProducts![profileController.trackBasedsubProduct.value],
            // if (trackLoanProductModel.value.brands != null)
            //   "farmBrand": trackLoanProductModel
            //       .value.brands![profileController.trackBasedbrand.value]
          },
        ),
      );
      if (response != null) {
        return true;
      } else {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();

      print("customer id===> ${customerId.value}");
      var response =
          await http.post(Uri.parse(baseUrl + Apis.recentTransactionLoan),
              body: json.encode({
                "customerId": customerId.value,
                // "loanType": "${getLoanType(loanType)}",
              }),
              headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer " + accessToken.toString()
          });
      // var response = await DioApiCall().commonApiCall(
      //   endpoint: Apis.recentTransactionLoan,
      //   method: Type.POST,
      //   data: json.encode({
      //     "customerId": customerId.value,
      //
      //     // "loanType": "${getLoanType(loanType)}",
      //   }),
      // );

      print("Json data ==> ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Json data ==> ${response.body}");
        var jsonData = jsonDecode(response.body);

        print("sending json data${jsonData}");
        print("data json data${jsonData['data']}");

        recentTransactionModel.value =
            RecentTransactionModel.fromJson(jsonData['data']);
      } else {
        Flushbar(
          title: "Error!",
          message: "Something went wrong ...",
          duration: Duration(seconds: 2),
        )..show(Get.context!);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }

  Future insuranceRecentTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    try {
      createLoanLoading.value = true;
      customerId.value = await profileController.getId();

      print("customer id===> ${customerId.value}");
      var response =
          await http.post(Uri.parse(baseUrl + Apis.insuranceDashboard),
              body: json.encode({
                "customerId": customerId.value,
              }),
              headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer " + accessToken.toString()
          });

      print("Json data ==> ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Json data ==> ${response.body}");
        var jsonData = jsonDecode(response.body);

        print("sending json data${jsonData}");
        print("data json data${jsonData['data']}");

        insuranceRecentTransactionModel.value =
            InsuranceRecentTransactionModel.fromJson(jsonData['data']);
      } else {
        Flushbar(
          title: "Error!",
          message: "Something went wrong ...",
          duration: Duration(seconds: 2),
        )..show(Get.context!);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createLoanLoading.value = false;
    }
  }

  // // operator list
  // callOperatorListApi() async {
  //   try {
  //     isLoading(true);
  //     var response =
  //     await http.get(Uri.parse(baseUrl + Apis.operatorList), headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       "x-digital-api-key": "1234"
  //     });
  //
  //     print("Operator response");
  //     print(response.body.toString());
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var jsonData = jsonDecode(response.body);
  //       RcOperatorModel rcOperatorModel = RcOperatorModel.fromJson(jsonData);
  //       if (rcOperatorModel.status!.code == 2000) {
  //         print(rcOperatorModel.data!.operators!);
  //         operatorList.clear();
  //         operatorListString.clear();
  //         for (var index in rcOperatorModel.data!.operators!) {
  //           operatorListSend.add(index);
  //           operatorListStringSend.add(index.name.toString());
  //         }
  //         operatorList.addAll(operatorListSend);
  //         operatorListString.addAll(operatorListStringSend);
  //         isLoading(false);
  //       } else {
  //         Flushbar(
  //           title: "Alert!",
  //           message: rcOperatorModel.status!.message,
  //           duration: Duration(seconds: 2),
  //         )..show(Get.context!);
  //       }
  //     } else {
  //       Flushbar(
  //         title: "Error!",
  //         message: "Something went wrong",
  //         duration: Duration(seconds: 2),
  //       )..show(Get.context!);
  //     }
  //   } catch (e) {
  //     Flushbar(
  //       title: "Error!",
  //       message: "Something went wrong",
  //       duration: Duration(seconds: 2),
  //     )..show(Get.context!);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  //
  // //circle list
  //
  // callCircleListApi() async {
  //   try {
  //     isLoading(true);
  //     var response =
  //     await http.get(Uri.parse(baseUrl + Apis.circleList), headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       "x-digital-api-key": "1234"
  //     });
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var jsonData = jsonDecode(response.body);
  //
  //       RcCircleModel circleModel = RcCircleModel.fromJson(jsonData);
  //
  //       if (circleModel.status!.code == 2000) {
  //         circleList.clear();
  //         circleListString.clear();
  //         for (var index in circleModel.data!.circles!) {
  //           circleListSend.add(index);
  //           circleListStringSend.add(index.name.toString());
  //         }
  //
  //         circleList.addAll(circleListSend);
  //         circleListString.addAll(circleListStringSend);
  //
  //         isLoading(false);
  //       } else {
  //         Flushbar(
  //           title: "Alert!",
  //           message: circleModel.status!.message,
  //           duration: Duration(seconds: 2),
  //         )..show(Get.context!);
  //       }
  //     } else {}
  //   } catch (e) {
  //     Flushbar(
  //       title: "Error!",
  //       message: "Something went wrong",
  //       duration: Duration(seconds: 2),
  //     )..show(Get.context!);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}

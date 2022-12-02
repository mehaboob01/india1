import 'dart:convert';

import 'package:get/get.dart';
import 'package:india_one/screens/insurances/insurance_common.dart';
import 'package:india_one/screens/insurances/model/insurance_application_model.dart';
import 'package:india_one/screens/insurances/model/insurance_summary_model.dart';
import 'package:india_one/screens/insurances/widgets/insurance_submission_page.dart';

import '../../../constant/routes.dart';
import '../../../core/data/remote/api_constant.dart';
import '../../../core/data/remote/dio_api_call.dart';
import '../../profile/controller/profile_controller.dart';

enum InsuranceStep { PERSONAL, RESIDENTIAL, OCCUPATION, NOMINEE, HEALTH }

class InsuranceController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  RxString insuranceFilter = "".obs;
  var currentScreen = InsuranceStep.PERSONAL.index.obs;
  RxBool createInsuranceApplicationLoading = false.obs;
  RxBool insuranceSummaryLoading = false.obs;
  RxString customerId = ''.obs;
  Rx<InsuranceApplicationModel> insuranceApplicationModel = InsuranceApplicationModel().obs;
  Rx<InsuranceSummaryModel> insuranceSummaryModel = InsuranceSummaryModel().obs;
  RxInt insuranceCompletedIndex = 0.obs;

  List<String> titleList = [
    "Personal",
    "Address",
    "Occupation",
    "Nominee",
    "Health",
  ];

  void updateScreen(index) {
    currentScreen.value = index;
  }

  void createInsuranceApplication(
      {required InsuranceType insuranceType}) async {
    try {
      createInsuranceApplicationLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.createInsurance,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          "insuranceType": "${getInsuranceType(insuranceType)}",
        }),
      );
      print("$response");
      if (response != null) {
        insuranceApplicationModel.value =
            InsuranceApplicationModel.fromJson(response);
      }
    } catch (exception) {
      print(exception);
    } finally {
      createInsuranceApplicationLoading.value = false;
    }
  }

  void fetchInsuranceSummary() async {
    try {
      insuranceSummaryLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: "${Apis.createInsurance}/${insuranceApplicationModel.value.id}/summary",
        method: Type.GET,
        // data: json.encode({
        //   "customerId": customerId.value,
        //   "insuranceType": "${getInsuranceType(insuranceType)}",
        // }),
      );
      print("$response");
      if (response != null) {
        insuranceSummaryModel.value =
            InsuranceSummaryModel.fromJson(response);
      }
    } catch (exception) {
      print(exception);
    } finally {
      insuranceSummaryLoading.value = false;
    }
  }
  void applyForInsurance() async {
    try {
      insuranceSummaryLoading.value = true;
      customerId.value = await profileController.getId();
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.applyForInsurance,
        method: Type.POST,
        data: json.encode({
          "customerId": customerId.value,
          "applicatonId": "${insuranceApplicationModel.value.id}",
          "acceptedToCVersion":"${insuranceSummaryModel.value.tocVersion}",
        }),
      );
      print("$response");
      // if (response != null) {
        Get.to(() => InsuranceSubmissionPage());
        Future.delayed(Duration(seconds: 3), () {
          Get.offNamedUntil(MRouter.homeScreen, (route) => route.isFirst);
        });
      // }
    } catch (exception) {
      print(exception);
    } finally {
      insuranceSummaryLoading.value = false;
    }
  }

  getInsuranceType(InsuranceType insuranceType) {
    if (insuranceType == InsuranceType.CriticalIllness) {
      return 'CriticalIllness';
    } else if (insuranceType == InsuranceType.Accidental) {
      return 'Accidental';
    }
    return '';
  }
}
import 'package:get/get.dart';

import '../../profile/controller/profile_controller.dart';

enum InsuranceStep { PERSONAL, RESIDENTIAL, OCCUPATION, NOMINEE, HEALTH }

class InsuranceController extends GetxController {
  ProfileController profileController = Get.put(ProfileController());
  RxString insuranceFilter = "".obs;
  var currentScreen = InsuranceStep.PERSONAL.index.obs;

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
}

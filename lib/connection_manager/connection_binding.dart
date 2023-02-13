import 'package:get/get.dart';
import 'package:india_one/screens/onboarding_login/select_language/select_lan_manager.dart';

import 'ConnectionManagerController.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
    Get.lazyPut<SelectLanManager>(() => SelectLanManager(), fenix: true);
  }
}

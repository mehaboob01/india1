import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_one/core/data/local/shared_preference_keys.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/theme_manager.dart';
import '../screens/home_start/home_manager.dart';

class ConnectionManagerController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  var connectionType = 0.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;
  var isShowing = false.obs;
  var ignorePointer = false.obs;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  ProfileController profileController = Get.put(ProfileController());
  HomeManager homeManager = Get.put(HomeManager());
  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:
        break;
    }

    if (connectionType.value == 0) {
      showSnackBar(
          title: " Checking for internet Connectivity",
          message: "Please enable your internet connection to proceed");
      ignorePointer.value = true;
    } else {
      ignorePointer.value = false;
      Get.closeAllSnackbars();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool? isLoggedIn = sharedPreferences.getBool(SPKeys.LOGGED_IN);
      if (isLoggedIn == true &&
          (profileController.profileDetailsModel.value.mobileNumber == null ||
              profileController.profileDetailsModel.value.mobileNumber == "" ||
              profileController.profileDetailsModel.value.mobileNumber!.length <
                  10)) {
        profileController.getProfileData();
        profileController.setData();
        homeManager.callHomeApi();
      }
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}

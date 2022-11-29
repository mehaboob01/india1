import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:india_one/screens/helpers/no_internet.dart';
import 'package:india_one/screens/helpers/update_available.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class VersionValidator extends GetxController {
  @override
  void onInit() {
    super.onInit();
    shouldUpdate(Get.context);
  }

  RxBool updateAvailable = false.obs;

  shouldUpdate(context) async {
    updateAvailable.value = true;
    PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));
    print(currentVersion.toString() + " Current Version");
    final FirebaseRemoteConfig remoteConfig =
        await FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.fetchAndActivate();
      var new_version = await remoteConfig.getString("latest_version");
      print(new_version);
      double latestVersion =
          double.parse(new_version.trim().replaceAll(".", ""));
      if (latestVersion > currentVersion) {
        updateAvailable.value = false;
        Get.to(() => Updateavailable());
      } else {
        print("No update available");
      }
    } on PlatformException catch (exception) {
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
      print(exception);
    }
    updateAvailable.value = false;
  }

  Future<void> launchUrl(_url) async {
    if (await canLaunchUrl(_url)) {
      launchUrl(_url);
    } else
      print("Cant launch");
  }
}

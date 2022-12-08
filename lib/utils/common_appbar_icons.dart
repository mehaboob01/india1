import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/routes.dart';
import '../constant/theme_manager.dart';
import '../core/data/local/shared_preference_keys.dart';
import '../widgets/loyalty_common_header.dart';

List<CustomActionIcons> commonAppIcons = [
  CustomActionIcons(
    image: AppImages.askIconSvg,
    onHeaderIconPressed: () async {
      // what to ask function goes here
    },
  ),
  CustomActionIcons(
    image: AppImages.bottomNavHomeSvg,
    onHeaderIconPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs!.setBool(SPKeys.SHOW_AUTH, false);
      Get.offNamedUntil(MRouter.homeScreen, (route) => route.isFirst);
    },
  ),
];

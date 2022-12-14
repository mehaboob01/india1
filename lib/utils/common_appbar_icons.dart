import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/routes.dart';
import '../constant/theme_manager.dart';
import '../core/data/local/shared_preference_keys.dart';
import '../core/data/remote/api_constant.dart';
import '../widgets/loyalty_common_header.dart';
import 'common_webview.dart';

List<CustomActionIcons> commonAppIcons = [
  CustomActionIcons(
    image: AppImages.askIconSvg,
    onHeaderIconPressed: () async {
      // what to ask function goes here
      Get.to(() => CommonWebView(
        title: 'Faq',
        url: Apis.Faq,
      ));
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

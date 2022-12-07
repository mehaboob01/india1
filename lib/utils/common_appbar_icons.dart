import 'package:get/get.dart';

import '../constant/routes.dart';
import '../constant/theme_manager.dart';
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
      Get.offNamedUntil(MRouter.homeScreen, (route) => route.isFirst);
    },
  ),
];

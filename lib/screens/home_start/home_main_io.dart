import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/text_io.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/divider_io.dart';
import '../../widgets/icon_io.dart';
import '../onboarding_login/select_language/language_selection_io.dart';

class HomeMainIO extends StatefulWidget {
  const HomeMainIO({Key? key}) : super(key: key);

  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DividerIO(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextIO('hello'.tr),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: IconIO(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageSelectionIO()),
                    );
                  },
                ),
                IconIO(Icons.notifications_active),
              ],
            )
          ],
        ),
        DividerIO(),
        Container(
          color: AppColors.whiteColor,
          height: 5,
        ),],
    );
  }
}

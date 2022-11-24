import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/theme_manager.dart';
import '../../core/data/remote/api_constant.dart';
import '../../utils/common_webview.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';

class SavingsPage extends StatelessWidget {
  //const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonPageHeader(pageName: PageName.savings),
              CommonPageCategoriesHeading(pageName: PageName.savings),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 2.0.hp, left: 4.0.wp, right: 4.0.wp),
                child: const SavingsCard(),
              ),
              CommonBanner()
            ],
          ),
        ),
      ),
    );
  }
}

class SavingsCard extends StatelessWidget {
  const SavingsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        InkWell(
          onTap: () {
            Get.to(() => CommonWebView(
              title: 'Fixed Deposit',
              url: Apis.fdLink,
            ));
          },
          child: ItemCard(
            image: AppImages.fdSvg,
            label: 'FD(Fixed Deposit)',
            itembgColor: ItemCardbgColor.skyBlue,
          ),
        ),
        // ItemCard(
        //   image: AppImages.rd,
        //   label: 'RD(Recurring Deposit)',
        //   itembgColor: ItemCardbgColor.skyBlue,
        // ),
        InkWell(
          onTap: () {
            Get.to(() => CommonWebView(
              title: 'Digi Gold',
              url: Apis.digiGold,
            ));
          },
          child: ItemCard(
            image: AppImages.goldSvg,
            label: 'Digi Gold',
            itembgColor: ItemCardbgColor.skyBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => CommonWebView(
              title: 'Digi Silver',
              url: Apis.digiGold,
            ));
          },
          child: ItemCard(
            image: AppImages.digiSilverSvg,
            label: 'Digi Silver',
            itembgColor: ItemCardbgColor.skyBlue,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/routes.dart';
import '../../constant/theme_manager.dart';
import '../../core/data/remote/api_constant.dart';
import '../../utils/common_webview.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';
import '../home_start/home_manager.dart';

class SavingsPage extends StatefulWidget {
  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  HomeManager _homeManager = Get.put(HomeManager());
  @override
  void initState() {
    super.initState();
    _homeManager.showAuth.value = false;
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  //const SavingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async{

          Navigator.of(context).pushNamedAndRemoveUntil(
              MRouter.homeScreen, (Route<dynamic> route) => false);
          return false;

        },

        child: IgnorePointer(
          ignoring: _controller.ignorePointer.value,
          child: Scaffold(
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
      children: [
        InkWell(
          onTap: () {
            Get.to(() => CommonWebView(
                  title: 'Fixed Deposit',
                  url: Apis.fdLink,
                ));
          },
          child: ItemCard(
            image: AppImages.fdSvg,
            label: 'fixed_deposit',
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
            label: 'digi_gold',
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
            label: 'digi_silver',
            itembgColor: ItemCardbgColor.skyBlue,
          ),
        ),
      ],
    );
  }
}

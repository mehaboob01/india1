import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/routes.dart';
import '../../constant/theme_manager.dart';
import '../../core/data/remote/api_constant.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';
import '../home_start/home_manager.dart';

class PaymentsPage extends StatefulWidget {
  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  HomeManager _homeManager = Get.put(HomeManager());

  @override
  void initState() {
    super.initState();
    _homeManager.showAuth.value = false;
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  //const PaymentsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonPageHeader(pageName: PageName.payments),
                  CommonPageCategoriesHeading(pageName: PageName.payments),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 2.0.hp, left: 4.0.wp, right: 4.0.wp),
                    child:  PaymentCards(),
                  ),
                  CommonBanner()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentCards extends StatelessWidget {
  HomeManager _homeManager = Get.put(HomeManager());




  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        InkWell(
          onTap: () async {
            _homeManager.callPaymentApi(Apis.payment_recharge,context);



          },
          child: ItemCard(
            image: AppImages.mobilRechargeSvg,
            label: 'recharge',
            itembgColor: ItemCardbgColor.lightRed,
          ),
        ),
        InkWell(
          onTap: () {
            _homeManager.callPaymentApi(Apis.payment_fastag,context);
            //  Get.toNamed(MRouter.carInsurance);
          },
          child: ItemCard(
            image: AppImages.fastagSvg,
            label: 'fast_teg',
            itembgColor: ItemCardbgColor.lightRed,
          ),
        ),
        InkWell(
          onTap: () {
            _homeManager.callPaymentApi(Apis.payment_dth,context);

            //  Get.toNamed(MRouter.carInsurance);
          },
          child: ItemCard(
              image: AppImages.dthSvg,
              label: 'dth',
              itembgColor: ItemCardbgColor.lightRed),
        ),
      ],
    );
  }
}

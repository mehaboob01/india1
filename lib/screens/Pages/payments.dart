// import 'package:flutter/material.dart';
// import 'package:india_one_ui/utils/extensions.dart';

import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';


class PaymentsPage extends StatelessWidget {
  //const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: const PaymentCards(),
              ),
               CommonBanner()
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentCards extends StatelessWidget {
  const PaymentCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children: const [
        ItemCard(
          image: AppImages.mobilRechargeSvg,
          label: 'Recharge',
          itembgColor: ItemCardbgColor.lightRed,
        ),
        ItemCard(
          image: AppImages.fastagSvg,
          label: 'FASTag',
          itembgColor: ItemCardbgColor.lightRed,
        ),
        ItemCard(
            image: AppImages.dthSvg,
            label: 'DTH',
            itembgColor: ItemCardbgColor.lightRed),
      ],
    );
  }
}
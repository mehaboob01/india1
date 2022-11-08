// import 'package:flutter/material.dart';
// import 'package:india_one_ui/utils/extensions.dart';

// import '../common_widgets.dart/common_loyalty_card.dart';

// import '../utils/theme_manager.dart';

// class PaymentsPage extends StatelessWidget {
//   const PaymentsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';


class SavingsPage extends StatelessWidget {
  //const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      children: const [
        ItemCard(
          image: AppImages.fdSvg,
          label: 'FD(Fixed Deposit)',
          itembgColor: ItemCardbgColor.skyBlue,
        ),
        // ItemCard(
        //   image: AppImages.rd,
        //   label: 'RD(Recurring Deposit)',
        //   itembgColor: ItemCardbgColor.skyBlue,
        // ),
        ItemCard(
          image: AppImages.goldSvg,
          label: 'Digi Gold',
          itembgColor: ItemCardbgColor.skyBlue,
        ),
        ItemCard(
          image: AppImages.digiSilverSvg,
          label: 'Digi Silver',
          itembgColor: ItemCardbgColor.skyBlue,
        ),
      ],
    );
  }
}

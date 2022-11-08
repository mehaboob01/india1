import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/constant/routes.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';


class LoansPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonPageHeader(pageName: PageName.loans),
              CommonPageCategoriesHeading(pageName: PageName.loans),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 2.0.hp, left: 4.0.wp, right: 4.0.wp),
                child: const LoansCard(),
              ),
               CommonBanner()
            ],
          ),
        ),
      ),
    );
  }
}

class LoansCard extends StatelessWidget {
  const LoansCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        GestureDetector(
          onTap: ()=> Get.toNamed(MRouter.chooseAmountIO),
          child: ItemCard(
            image: AppImages.handRupeeSvg,
            label: 'Personal',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        ItemCard(
          image: AppImages.bikeSvg,
          label: 'Bike',
          itembgColor: ItemCardbgColor.lightBlue,
        ),
        ItemCard(
            image: AppImages.carSvg,
            label: 'Car',
            itembgColor: ItemCardbgColor.lightBlue),
        ItemCard(
          image: AppImages.tractorSvg,
          label: 'Tractor',
          itembgColor: ItemCardbgColor.lightBlue,
        ),
        ItemCard(
          image: AppImages.handSackSvg,
          label: 'MSME',
          itembgColor: ItemCardbgColor.lightBlue,
        ),
        ItemCard(
          image: AppImages.goldSvg,
          label: 'Gold',
          itembgColor: ItemCardbgColor.lightBlue,
        ),
        ItemCard(
          image: AppImages.creditCardSvg,
          label: 'Credit Card',
          itembgColor: ItemCardbgColor.lightBlue,
        ),
        ItemCard(
          image: AppImages.creditScoreSvg,
          label: 'Credit Score',
          itembgColor: ItemCardbgColor.lightBlue,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/widgets/card.dart';


class LoansPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        GestureDetector(
          onTap: (){

            Get.toNamed(MRouter.chooseAmountIO);

          },
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

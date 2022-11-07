import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/widgets/card.dart';


class SavingsPage extends StatelessWidget {


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

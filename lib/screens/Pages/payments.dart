import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/widgets/card.dart';


class PaymentsPage extends StatelessWidget {


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
          label: 'Fastag',
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

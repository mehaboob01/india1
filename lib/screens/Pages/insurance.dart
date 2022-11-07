import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/widgets/card.dart';


class InsurancePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children: const [
        ItemCard(
          image: AppImages.lifeSvg,
          label: 'Life',
          itembgColor: ItemCardbgColor.lightRed2,
        ),
        ItemCard(
          image: AppImages.bikeSvg,
          label: '2 Wheeler',
          itembgColor: ItemCardbgColor.lightRed2,
        ),
        ItemCard(
          image: AppImages.carSvg,
          label: '4 Wheeler',
          itembgColor: ItemCardbgColor.lightRed2,
        ),
        ItemCard(
          image: AppImages.criticalIllnessSvg,
          label: 'Critical Illness',
          itembgColor: ItemCardbgColor.lightRed2,
        ),

      ],
    );
  }
}

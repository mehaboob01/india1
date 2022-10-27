import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';


class InsurancePage extends StatelessWidget {
 // const InsurancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        ItemCard(
          image: AppImages.life,
          label: 'Life',
          isblue: false,
        ),
        ItemCard(
          image: AppImages.bike,
          label: '2 Wheeler',
          isblue: false,
        ),
        ItemCard(
          image: AppImages.car,
          label: '4 Wheeler',
          isblue: false,
        ),
        ItemCard(
          image: AppImages.criticalIllness,
          label: 'Critical Illness',
          isblue: false,
        ),
        ItemCard(
          image: AppImages.accident,
          label: 'Accident',
          isblue: false,
        ),
        ItemCard(
          image: AppImages.hopicash,
          label: 'Hopicash',
          isblue: false,
        )
      ],
    );
  }
}

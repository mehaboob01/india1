import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';


class LoansPage extends StatelessWidget {
  //const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        ItemCard(
          image: AppImages.handRupee,
          label: 'Personal',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.bike,
          label: 'Bike',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.handSack,
          label: 'MSME',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.tractor,
          label: 'Tractor',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.creditCard,
          label: 'Credit Card',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.gold,
          label: 'Gold',
          isblue: true,
        )
      ],
    );
  }
}

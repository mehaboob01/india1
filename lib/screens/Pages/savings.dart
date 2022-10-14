import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';


class SavingsPage extends StatelessWidget {
 // const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        ItemCard(
          image: AppImages.fd,
          label: 'FD(Fixed Deposit)',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.rd,
          label: 'RD(Recurring Deposit)',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.gold,
          label: 'Digi Gold',
          isblue: true,
        ),
        ItemCard(
          image: AppImages.digiSilver,
          label: 'Digi Silver',
          isblue: true,
        ),
      ],
    );
  }
}

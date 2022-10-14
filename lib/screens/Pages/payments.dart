import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';


class PaymentsPage extends StatelessWidget {
 // const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children:  [
        ItemCard(
          image: AppImages.mobilRecharge,
          label: 'Recharge',
          isblue: false,
        ),
        ItemCard(
          image: AppImages.fastag,
          label: 'Fastag',
          isblue: false,
        ),
        ItemCard(
          image: AppImages.dth,
          label: 'DTH',
          isblue: false,
        ),
      ],
    );
  }
}

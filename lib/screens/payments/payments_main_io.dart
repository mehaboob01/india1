import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/widgets/text_io.dart';

class PaymentsMainIO extends StatefulWidget {
  const PaymentsMainIO({Key? key}) : super(key: key);

  @override
  State<PaymentsMainIO> createState() => _PaymentsMainIOState();
}

class _PaymentsMainIOState extends State<PaymentsMainIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(
        "Payments Screen",
        overflow: TextOverflow.visible,
        maxLines: 1,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          color:  AppColors.white,
          fontSize: Dimens.font_16sp,
        ),
      ),),
    );
  }
}

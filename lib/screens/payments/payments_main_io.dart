import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

class PaymentsMainIO extends StatefulWidget {
  const PaymentsMainIO({Key? key}) : super(key: key);

  @override
  State<PaymentsMainIO> createState() => _PaymentsMainIOState();
}

class _PaymentsMainIOState extends State<PaymentsMainIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: text(
          "Payments Screen",
          textOverflow: TextOverflow.visible,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.visible,
            color: AppColors.primary,
            fontSize: Dimens.font_16sp,
          ),
        ),
      ),
    );
  }
}

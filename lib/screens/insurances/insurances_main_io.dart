import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/widgets/text_io.dart';

class InsurancesMainIO extends StatefulWidget {
  const InsurancesMainIO({Key? key}) : super(key: key);

  @override
  State<InsurancesMainIO> createState() => _InsurancesMainIOState();
}

class _InsurancesMainIOState extends State<InsurancesMainIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(
        "Insurance Screen",
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

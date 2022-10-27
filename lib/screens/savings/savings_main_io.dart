import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';


class SavingsMainIO extends StatefulWidget {
  const SavingsMainIO({Key? key}) : super(key: key);

  @override
  State<SavingsMainIO> createState() => _SavingsMainIOState();
}

class _SavingsMainIOState extends State<SavingsMainIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(
        "Saving Screen",
        overflow: TextOverflow.visible,
        maxLines: 1,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
          color:  AppColors.primary,
          fontSize: Dimens.font_16sp,
        ),
      ),),
    );
  }
}

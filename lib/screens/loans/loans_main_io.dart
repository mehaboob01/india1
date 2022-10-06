import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/widgets/text_io.dart';

class LoansMainIO extends StatefulWidget {
  const LoansMainIO({Key? key}) : super(key: key);

  @override
  State<LoansMainIO> createState() => _LoansMainIOState();
}

class _LoansMainIOState extends State<LoansMainIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(
        "Loans Screen",
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

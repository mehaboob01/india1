import 'package:flutter/material.dart';
import 'package:india_one/widgets/text_io.dart';

import '../../constant/theme_manager.dart';

class HomeMainIO extends StatefulWidget {
  const HomeMainIO({Key? key}) : super(key: key);

  @override
  State<HomeMainIO> createState() => _HomeMainIOState();
}

class _HomeMainIOState extends State<HomeMainIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(
        "Home Screen",
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

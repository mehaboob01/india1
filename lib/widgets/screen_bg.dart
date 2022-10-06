
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../constant/theme_manager.dart';



class BgScreen extends StatelessWidget {
  const BgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgScreenColor,
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          SizedBox(height: 32),
          Center(
            child: Hero(
              tag: 'logo_image',
              child: Image.asset(
                "assets/images/india_one_logo.png",
                width: 244,
                height: 184,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


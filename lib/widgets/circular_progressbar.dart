import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constant/theme_manager.dart';

class CircularProgressbar extends StatelessWidget {
  const CircularProgressbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoadingAnimationWidget.inkDrop(
              size: 36,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text('Loading ...',
              style: AppStyle.shortHeading.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}

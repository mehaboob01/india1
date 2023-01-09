import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constant/theme_manager.dart';

class CircularProgressbar extends StatelessWidget {
  const CircularProgressbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
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
              text('Loading ...',
                  style: AppStyle.shortHeading.copyWith(
                      color: AppColors.black, fontWeight: FontWeight.w400))
            ],
          ),
        ),
      ),
    );
  }
}

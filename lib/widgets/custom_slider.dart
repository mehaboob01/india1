import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';
import 'custom_slider_thumb.dart';


class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.sliderValue,
    required this.minValue,
    required this.maxValue,
    this.textEditingController,
  }) : super(key: key);

  final Rx<double> sliderValue;
  final Rx<double> minValue;
  final Rx<double> maxValue;
  //final CashBackController getController;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.white,
              valueIndicatorTextStyle: AppStyle.shortHeading.copyWith(
                  color: AppColors.backGroundgradient1,
                  fontSize: 11.0.sp,
                  fontWeight: FontWeight.w600),
              thumbShape:  SliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10.0),
              trackHeight: 8.0.wp,
            ),
            child: Slider(
                value: sliderValue.value,
                label: sliderValue.value.round().toString(),
                min: minValue.value,
                max: maxValue.value,
                thumbColor: Colors.white,
                activeColor: AppColors.backGroundgradient1,
                inactiveColor: const Color(0xffE0F0FF),
                onChanged: (value) {
                  sliderValue.value = value;
                  textEditingController!.text = value.round().toString();
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${minValue.toInt()}',
                  style: AppStyle.shortHeading.copyWith(
                      color: AppColors.black,
                      fontSize: 11.0.sp,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${maxValue.toInt()}',
                  style: AppStyle.shortHeading.copyWith(
                      color: AppColors.black,
                      fontSize: 11.0.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}

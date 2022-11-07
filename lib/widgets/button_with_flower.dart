import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../constant/theme_manager.dart';


class ButtonWithFlower extends StatelessWidget {
  const ButtonWithFlower({

    required this.label,
    this.iconColor,
    this.buttonColor,
    required this.onPressed,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.labelSize,
    required this.labelColor,
    required this.labelWeight,
    this.iconToRight = true,
    this.buttonGradient,
  });
  final String label;
  final Color? iconColor;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final double labelSize;
  final Color labelColor;
  final FontWeight labelWeight;
  final bool iconToRight;
  final Color? buttonColor;
  final Gradient? buttonGradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
              gradient: buttonGradient,
              color: buttonColor,
              borderRadius: BorderRadius.circular(2.0.wp)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: AppStyle.shortHeading.copyWith(
                      fontSize: labelSize,
                      fontWeight: labelWeight,
                      color: labelColor,
                      letterSpacing: 0.5),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: iconToRight
                      ? Image.asset(
                          AppImages.bgflower,
                          fit: BoxFit.fill,
                          color: iconColor,
                        )
                      : null)
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:india_one/constant/theme_manager.dart';

class CommonRoundedLogo extends StatelessWidget {
  const CommonRoundedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: FittedBox(child: SvgPicture.asset(AppImages.newIndiaOneSvg)),
    );
  }
}

class HeadingBox extends StatelessWidget {
  const HeadingBox(
      {this.icon,
      this.image,
      this.text,
      this.ontap,
      this.color,
      this.imgColor});

  final IconData? icon;
  final String? image;
  final String? text;
  final Color? imgColor;
  final VoidCallback? ontap;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.all(1.0),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: text != null
            ? Center(
                child: Text(
                text!,
                textScaleFactor: 1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ))
            : image != null
                ? Center(
                    child: SvgPicture.asset(
                    image!,
                    color: imgColor ?? Colors.black,
                  ))
                : Icon(icon),
      ),
    );
  }
}

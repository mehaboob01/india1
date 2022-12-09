import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeadingBox extends StatelessWidget {
  const HeadingBox({this.icon, this.image, this.text, this.ontap, this.color});

  final IconData? icon;
  final String? image;
  final String? text;
  final VoidCallback? ontap;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.all(4.0),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: text != null
            ? Center(
                child: Text(
                text!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ))
            : image != null
                ? Center(
                    child: SvgPicture.asset(
                    image!,
                    color: Colors.white,
                  ))
                : Icon(icon),
      ),
    );
  }
}

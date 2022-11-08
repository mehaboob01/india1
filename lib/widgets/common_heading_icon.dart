import 'package:flutter/material.dart';
class HeadingIconsBox extends StatelessWidget {
  const HeadingIconsBox({

    this.icon,
    this.image,
    this.text,
    this.ontap,
  });
  final VoidCallback? ontap;
  final IconData? icon;
  final String? image;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: text != null
            ? Center(
            child: Text(
              text!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))
            : image != null
            ? Image.asset(image!)
            : Icon(icon),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class HeadingIconsBox extends StatefulWidget {
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
  State<HeadingIconsBox> createState() => _HeadingIconsBoxState();
}

class _HeadingIconsBoxState extends State<HeadingIconsBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: widget.text != null
            ? Center(
                child: Text(
                widget.text!,
                textScaleFactor: 1,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ))
            : widget.image != null
                ? Image.asset(widget.image!, color: Colors.black)
                : Icon(widget.icon, color: Colors.black),
      ),
    );
  }
}

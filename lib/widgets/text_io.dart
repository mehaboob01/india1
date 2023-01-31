import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../constant/theme_manager.dart';

class TextIO extends StatefulWidget {
  String text;
  double size;
  int maxlines;
  Color color;
  FontWeight fontWeight;
  double padding;

  TextIO(this.text,
      {this.size = 18,
      this.maxlines = 1,
      this.color = AppColors.textColor,
      this.fontWeight = FontWeight.w500,
      this.padding = 9,
      Key? key})
      : super(key: key);

  @override
  State<TextIO> createState() => _TextIOState();
}

class _TextIOState extends State<TextIO> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: text(
        widget.text,
        textScaleFactor: 0.8,
        style: TextStyle(
            fontSize: widget.size,
            color: widget.color,
            fontWeight: widget.fontWeight),
        maxLines: widget.maxlines,
        textAlign: TextAlign.center,
      ),
    );
  }
}

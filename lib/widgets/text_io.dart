import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextIO extends StatefulWidget {
  String text;
  double size;
  int maxlines;
  Color color;
  FontWeight fontWeight;

  TextIO(this.text,
      {this.size = 18,
      this.maxlines = 1,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      Key? key})
      : super(key: key);

  @override
  State<TextIO> createState() => _TextIOState();
}

class _TextIOState extends State<TextIO> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(fontSize: widget.size, color: widget.color,fontWeight: widget.fontWeight),
      maxLines: widget.maxlines,
    );
  }
}

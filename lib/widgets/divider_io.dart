import 'package:flutter/material.dart';

class DividerIO extends StatefulWidget {
  Color color;
  double height;

  DividerIO({this.color = Colors.transparent, this.height = 5, Key? key})
      : super(key: key);

  @override
  State<DividerIO> createState() => _DividerIOState();
}

class _DividerIOState extends State<DividerIO> {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: widget.color,
      height: widget.height,
    );
  }
}

import 'package:flutter/material.dart';

import '../constant/theme_manager.dart';



class IconIO extends StatefulWidget {
  IconData iconData;
  double padding;
  var onpressed;
  Color color;

  IconIO(this.iconData,
      {this.padding = 9,
      this.onpressed,
      this.color = AppColors.buttonColor,
      Key? key})
      : super(key: key);

  @override
  State<IconIO> createState() => _IconIOState();
}

class _IconIOState extends State<IconIO> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: GestureDetector(
        onTap: widget.onpressed,
        child: Icon(
          widget.iconData,
          color: widget.color,
        ),
      ),
    );
  }
}

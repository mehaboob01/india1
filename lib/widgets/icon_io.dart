import 'package:flutter/material.dart';


class IconIO extends StatefulWidget {
  IconData iconData;
  double padding;

  IconIO(this.iconData, {this.padding = 9, Key? key}) : super(key: key);

  @override
  State<IconIO> createState() => _IconIOState();
}

class _IconIOState extends State<IconIO> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: Icon(
        widget.iconData,
        color: Colors.orange,
      ),
    );
  }
}

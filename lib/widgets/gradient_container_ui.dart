import 'package:flutter/material.dart';

class GradientContainerUI extends StatefulWidget {
  bool selected;
  Color? color1, color2;
  Widget child;
  double topBottomPadding;

  GradientContainerUI(
      {required this.child,
      this.color1,
      this.color2,
      this.selected = false,
      this.topBottomPadding = 0,
      Key? key})
      : super(key: key);

  @override
  State<GradientContainerUI> createState() => _GradientContainerUIState();
}

class _GradientContainerUIState extends State<GradientContainerUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.fromLTRB(
          0, widget.topBottomPadding, 0, widget.topBottomPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: widget.selected
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [
                    widget.color1!,
                    widget.color2!,
                  ],
                )
              : LinearGradient(colors: [Colors.grey, Colors.grey])),
      child: widget.child,
    );
  }
}

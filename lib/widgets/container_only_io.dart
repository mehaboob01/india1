import 'package:flutter/material.dart';

class ContainerOnlyIO extends StatefulWidget {
  List<double> radius;
  List<double> padding;
  Widget child;
  double height, width;
  Color color;

  ContainerOnlyIO(this.radius, this.child, this.padding,
      {this.height = 0, this.width = 0, this.color = Colors.white, Key? key})
      : super(key: key);

  @override
  State<ContainerOnlyIO> createState() => _ContainerOnlyIOState();
}

class _ContainerOnlyIOState extends State<ContainerOnlyIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.fromLTRB(widget.padding[0], widget.padding[1],
          widget.padding[2], widget.padding[3]),
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(widget.radius[0]),
            bottomRight: Radius.circular(widget.radius[1]),
            bottomLeft: Radius.circular(widget.radius[2]),
            topLeft: Radius.circular(widget.radius[3]),
          )),
      child: widget.child,
    );
  }
}

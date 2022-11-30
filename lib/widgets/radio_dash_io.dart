import 'package:flutter/material.dart';

class RadioDashIO extends StatefulWidget {
  const RadioDashIO({Key? key}) : super(key: key);

  @override
  State<RadioDashIO> createState() => _RadioDashIOState();
}

class _RadioDashIOState extends State<RadioDashIO> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 36,
      margin: EdgeInsets.all(5),
      color: Color.fromRGBO(153, 153, 153, 1.0),
    );
  }
}

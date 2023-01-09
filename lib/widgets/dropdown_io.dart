import 'package:flutter/material.dart';

import '../constant/theme_manager.dart';

class DropdownIO extends StatefulWidget {
  String hint, label;
  String? error;
  List<String> items = [];
  var onchanged;

  DropdownIO(
      {required this.hint,
      required this.label,
      required this.error,
      required this.items,
      required this.onchanged,
      Key? key})
      : super(key: key);

  @override
  State<DropdownIO> createState() => _DropdownIOState();
}

class _DropdownIOState extends State<DropdownIO> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        errorText: widget.error,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 9),
        hintText: widget.hint,
        labelText: widget.label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(9))),
      ),
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.all(3),
            child: text(value, style: new TextStyle(color: Colors.black)),
          ),
        );
      }).toList(),
      onChanged: widget.onchanged,
    );
  }
}

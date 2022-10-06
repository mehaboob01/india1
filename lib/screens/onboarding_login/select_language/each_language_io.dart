import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:india_one/widgets/text_io.dart';

class EachLanguageIO extends StatefulWidget {
  String text;
  var onpressed;

  EachLanguageIO(this.text, this.onpressed, {Key? key}) : super(key: key);

  @override
  State<EachLanguageIO> createState() => _EachLanguageIOState();
}

class _EachLanguageIOState extends State<EachLanguageIO> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpressed,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 72,
            width: 135,
            color: Colors.grey,
            child: Center(child: TextIO(widget.text)),
          ),
        ),
      ),
    );
  }
}

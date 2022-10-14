
import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/widgets/text_io.dart';

class EachLanguageIO extends StatefulWidget {
  String text;
  var onpressed;
  Color color;
  Color textColor;

  EachLanguageIO(this.text, this.onpressed, this.color, this.textColor,
      {Key? key})
      : super(key: key);

  @override
  State<EachLanguageIO> createState() => _EachLanguageIOState();
}

class _EachLanguageIOState extends State<EachLanguageIO> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpressed,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Container(
            height: 68,
            width: 164,
            color: widget.color,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                widget.textColor == AppColors.white ?
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ):Icon(
                  Icons.circle,
                  color: Colors.white,
                ),
               SizedBox(width: 4,),
                TextIO(
                  widget.text,
                  color: widget.textColor,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

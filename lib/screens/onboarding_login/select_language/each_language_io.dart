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
        child: Container(
          height: 68,
          width: 164,
         // color: widget.color,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.textColor == AppColors.white
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.circle,
                        color: AppColors.greyBgColor,
                      ),
                SizedBox(
                  width: 12,
                ),
                Center(

                  child: Text(
                    widget.text,
                      maxLines: 2,
                      style:TextStyle(


                          fontWeight: FontWeight.w600,
                          color: widget.textColor,
                          fontSize: Dimens.font_18sp,
                          fontFamily: 'Graphik'
                      )
                  ),
                ),
              ],
            ),
          ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                border: Border.all(
                  color: AppColors.black26Color,
                  width: 0.5,
                ),
                // radius of 10
                color: widget.color // green as background color
            )
        ),
      ),
    );
  }
}

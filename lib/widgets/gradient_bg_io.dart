import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'text_io.dart';

class GradientBGIO extends StatefulWidget {
  String text;
  var onpressed;
  bool selected;
  Color color1, color2;

  GradientBGIO(
      this.text, this.onpressed, this.selected, this.color1, this.color2,
      {Key? key})
      : super(key: key);

  @override
  State<GradientBGIO> createState() => _GradientBGIOState();
}

class _GradientBGIOState extends State<GradientBGIO> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: widget.selected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                    colors: [
                      widget.color1,
                      widget.color2,
                    ],
                  )
                : LinearGradient(colors: [Colors.grey, Colors.grey])),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            TextIO(
              widget.text,
              maxlines: 2,
              size: Dimens.font_16sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
            Spacer(),
            SizedBox(
              height: 42,
              child: Image.asset(
                "assets/images/btn_img.png",
                fit: BoxFit.fill,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

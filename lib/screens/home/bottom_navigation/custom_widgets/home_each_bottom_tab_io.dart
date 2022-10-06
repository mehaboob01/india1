import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

import '../../../../widgets/text_io.dart';


class HomeEachBottomTabIO extends StatefulWidget {
  IconData icondata;
  String title;
  var onpressed;
  bool selected;
  double size;

  HomeEachBottomTabIO(
      this.icondata, this.title, this.onpressed, this.selected, this.size,
      {Key? key})
      : super(key: key);

  @override
  State<HomeEachBottomTabIO> createState() => _HomeEachBottomTabIOState();
}

class _HomeEachBottomTabIOState extends State<HomeEachBottomTabIO> {
  double heightIs = 0, widthIs = 0;

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onpressed,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: widget.selected
                ? const Color.fromRGBO(102, 90, 165, 1.0)
                : AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(18))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Icon(
                widget.icondata,
                color: widget.selected
                    ? AppColors.white
                    : AppColors.btnColor,
              ),
            ),
            widget.selected
                ? TextIO(
                    widget.title,
                    color: AppColors.white,
                    size: widget.size,
                    fontWeight: FontWeight.bold,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

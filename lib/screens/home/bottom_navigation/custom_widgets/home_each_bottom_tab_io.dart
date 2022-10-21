import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:india_one/constant/theme_manager.dart';

import '../../../../constant/other_constants_io.dart';
import '../../../../widgets/text_io.dart';

class HomeEachBottomTabIO extends StatefulWidget {
  String path;
  String title;
  var onpressed;
  bool selected;
  double size;
  String dotImagePath;

  HomeEachBottomTabIO(this.path, this.dotImagePath, this.title, this.onpressed,
      this.selected, this.size,
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
      child: Stack(
        children: [
          widget.selected
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  height: bottomNavigationCircleRadius,
                  width: bottomNavigationCircleRadius,
                )
              : Container(),
          Container(
            decoration: widget.selected
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  )
                : BoxDecoration(),
            height: bottomMargin + 36,
            width: widthIs / 5.4,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 2,
                    ),
                    SvgPicture.asset(
                      widget.dotImagePath,
                      color: widget.selected == true ? AppColors.primary : null,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SvgPicture.asset(
                      widget.path,
                      color: widget.selected == true ? AppColors.primary : null,
                    ),
                    TextIO(
                      widget.title,
                      color: widget.selected
                          ? AppColors.primary
                          : AppColors.passiveTabColor,
                      size: widget.size,
                      fontWeight: FontWeight.bold,
                    ),
                    // SvgPicture.asset('assets/images/underline.svg'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

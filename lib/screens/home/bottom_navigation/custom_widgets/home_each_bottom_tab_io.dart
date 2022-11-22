import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:india_one/constant/theme_manager.dart';

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
                      'assets/images/dot_img.svg',
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
                      size: widget.selected == true?Dimens.font_14sp :Dimens.font_12sp,
                      fontWeight: widget.selected == true ?FontWeight.w400 :FontWeight.w500,
                    ),
                    SvgPicture.asset(
                      widget.dotImagePath,
                      color: widget.selected == true ? AppColors.primary : null,
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

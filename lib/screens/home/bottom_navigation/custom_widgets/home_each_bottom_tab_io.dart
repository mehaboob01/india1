import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';

import '../../../../connection_manager/ConnectionManagerController.dart';
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

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: GestureDetector(
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
                width: widthIs / 5.2,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        // widget.selected == true
                        //     ? SizedBox(
                        //         width: 5,
                        //         height: 5,
                        //         child: Image.asset(AppImages.profile_bg))
                        //     : SizedBox.shrink(),
                        SvgPicture.asset(
                          'assets/images/dot_img.svg',
                          color: widget.selected == true
                              ? AppColors.primary
                              : null,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SvgPicture.asset(
                          widget.path,
                          color: widget.selected == true
                              ? AppColors.primary
                              : null,
                        ),
                        TextIO(
                          widget.title,
                          color: widget.selected
                              ? AppColors.primary
                              : AppColors.passiveTabColor,
                          size: widget.selected == true
                              ? Dimens.font_14sp
                              : Dimens.font_12sp,
                          fontWeight: widget.selected == true
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                        // widget.selected == true
                        //     ? Container(
                        //         height: 2,
                        //         decoration: BoxDecoration(
                        //           gradient: LinearGradient(
                        //               begin: Alignment(-0.6, -0.6),
                        //               // end: Alignment(0.8, 0.4),
                        //               colors: [
                        //                 AppColors.blueColor,
                        //                 AppColors.redColor
                        //               ]),
                        //         ),
                        //       )
                        //     : SizedBox.shrink()
                        SvgPicture.asset(
                          widget.dotImagePath,
                          color: widget.selected == true
                              ? AppColors.primary
                              : null,
                        ),
                        SvgPicture.asset('assets/images/underline.svg'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

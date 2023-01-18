import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constant/theme_manager.dart';

class CircularProgressbar extends StatelessWidget {
  const CircularProgressbar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          fit: StackFit.expand,
          children: [



            Stack(
              children:
                [    ClipRRect( // Clip it cleanly.
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color: AppColors.transparent,
                      alignment: Alignment.center,
                      child:  SvgPicture.asset(AppImages.newIndiaOneSvg,   fit: BoxFit.cover,
                        height: 16,
                        width: 16,),
                    ),
                  ),
                ),
                  Center(
                    child: Container(
                      height: Get.height*0.1,
                      width: Get.height*0.1,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.orangeGradient2, //<-- SEE HERE
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                  ),]

            ),
          ],
        ),
      ),
    );
  }




    // return
    //   Stack(
    //   children:
    //
    // [
    // Container(
    //
    // margin: EdgeInsets.all(20.0),
    // padding: EdgeInsets.all(20.0),
    // decoration: BoxDecoration(
    // color: const Color(0xFFB4C56C).withOpacity(0.01),
    // borderRadius: BorderRadius.all(Radius.circular(50.0)),
    // ),
    //   child:    Center(
    //     child: SizedBox(
    //       width: 200,
    //       height: 200,
    //       child: Stack(
    //         alignment: Alignment.center,
    //         children: [
    //           // Image.asset(
    //           //   '',
    //           //
    //           //   fit: BoxFit.cover,
    //           //   height: 30,
    //           //   width: 30,
    //           // ),
    //           SvgPicture.asset(AppImages.newIndiaOneSvg,   fit: BoxFit.cover,
    //             height: 24,
    //             width: 24,),
    //           // you can replace
    //           const CircularProgressIndicator(
    //             valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
    //             strokeWidth: 2,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    //
    //
    // ]
    // );
  }

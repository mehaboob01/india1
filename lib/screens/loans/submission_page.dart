import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';

import '../../connection_manager/ConnectionManagerController.dart';

class SubmissionPage extends StatelessWidget {
   SubmissionPage({Key? key}) : super(key: key);

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body:
          Column(
            children: [
              Expanded(
                flex: 6,
                child:  Center(
                  child: Image.asset(
                    "assets/images/success.gif",
                    width: 320,
                    height: 320,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      "Loan application submitted!",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: Dimens.font_24sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "The team will get back to you.",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: Dimens.font_20sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

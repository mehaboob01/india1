import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';

class ConnectionLost extends StatelessWidget {
  const ConnectionLost({key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: Get.height * 0.4,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(AppImages.homebg), fit: BoxFit.fill),
              ),
            ),
            Positioned(
              bottom: 50,
              top: 50,
              right: 50,
              left: 50,
              child: Icon(
                Icons.signal_wifi_off,
                color: Colors.red,
                size: 100,
              ),
            ),
            Positioned(
              bottom: 80,
              left: 50,
              right: 50,
              child: Text(
                "Oops!",
                style: TextStyle(color: Colors.red, fontSize: Dimens.font_18sp),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "You are offline, please connect to a network and try again.",
              style: TextStyle(
                  color: AppColors.primary, fontSize: Dimens.font_18sp),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

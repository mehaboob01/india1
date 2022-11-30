import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Get.height * 0.25,
              width: double.infinity,
              child: Image.asset('assets/CloudAlert.gif'),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Text(
              "No Internet connection",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              "There seems to be network issue. Please check and try again",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

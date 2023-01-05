import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/theme_manager.dart';

class BikeInsurance extends StatefulWidget {
  @override
  State<BikeInsurance> createState() => _BikeInsuranceState();
}

class _BikeInsuranceState extends State<BikeInsurance> {
  double heightIs = 0, widthIs = 0;
  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar('2 Wheeler Insurance'),
          body: SafeArea(
              child: Column(
            children: [
              LinearProgressIndicator(
                color: AppColors.primary,
                backgroundColor: Colors.black38,
                value: progress,
              ),
              Expanded(
                child: WebView(
                  initialUrl:
                      'https://www.godigit.com/partner/two-wheeler-insurance?utm_source=partner&utm_medium=email&utm_campaign=IndiaOne&utm_content=teleblock&imdKey=F355351E7D59822A22B60E6E82527C0A',
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (progress) => setState(() {
                    this.progress = progress / 100 as double;
                  }),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

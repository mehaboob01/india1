import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constant/theme_manager.dart';

class CarInsurance extends StatefulWidget {
  @override
  State<CarInsurance> createState() => _CarInsuranceState();
}

class _CarInsuranceState extends State<CarInsurance> {
  double heightIs = 0, widthIs = 0;

  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:appBar('Car Insurance'),

  resizeToAvoidBottomInset: false, 
      body:
      SafeArea(
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
                  'https://www.godigit.com/partner/go-digit-car-insurance?utm_source=partner&utm_medium=email&utm_campaign=IndiaOne&utm_content=teleblock&imdKey=F355351E7D59822A22B60E6E82527C0A',
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (progress) => setState(() {
                    this.progress = progress / 100 as double;
                  }),
                ),
              ),
            ],
          )


      )

    );
  }
}

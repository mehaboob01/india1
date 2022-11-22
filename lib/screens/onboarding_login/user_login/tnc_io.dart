import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constant/theme_manager.dart';

class Tnc_IO extends StatefulWidget {
  const Tnc_IO({Key? key}) : super(key: key);

  @override
  State<Tnc_IO> createState() => _Tnc_IOState();
}

class _Tnc_IOState extends State<Tnc_IO> {
  double heightIs = 0, widthIs = 0;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar('term_condition'),
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
                  'https://india1payments.in/terms-and-conditions/index.html',
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (progress) => setState(() {
                this.progress = progress / 100 as double;
              }),
            ),
          ),
        ],
      )),
    );
  }
}

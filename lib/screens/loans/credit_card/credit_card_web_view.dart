import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constant/theme_manager.dart';

class CreditCardWebView extends StatefulWidget {
  @override
  State<CreditCardWebView> createState() => _CreditCardWebViewState();
}

class _CreditCardWebViewState extends State<CreditCardWebView> {
  double heightIs = 0, widthIs = 0;

  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar('Credit Card'),
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
                  'https://applycc.yesbank.in/YESBankCreditCard?uid=ab180',
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

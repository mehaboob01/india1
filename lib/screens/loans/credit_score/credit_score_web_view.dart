import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constant/theme_manager.dart';

class CreditScore extends StatefulWidget {
  @override
  State<CreditScore> createState() => _CreditScoreState();
}

class _CreditScoreState extends State<CreditScore> {
  double heightIs = 0, widthIs = 0;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar('Credit Score'),
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
                    'https://www.creditmantri.com/alliance/?utm_content=alliance-lp&alliance_lender=india1&utm_campaign=alliances&utm_source=india1_PWA_EN&utm_term=alliance_india1&utm_medium=alliance',
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (progress) => setState(() {
                  this.progress = progress / 100 as double;
                }),
              ),
            ),
          ],
        )));
  }
}

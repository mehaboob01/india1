import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constant/theme_manager.dart';

class EmiCard extends StatefulWidget {
  @override
  State<EmiCard> createState() => _EmiCardState();
}

class _EmiCardState extends State<EmiCard> {
  double heightIs = 0, widthIs = 0;

  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar('Emi Card'),
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
                    'https://www.bajajfinserv.in/insta-emi-network-card-apply-online?utm_source=RPMGA&utm_medium=Ind108&utm_campaign=A',
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

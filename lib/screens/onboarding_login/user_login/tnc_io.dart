import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

import '../../../constant/theme_manager.dart';

class Tnc_IO extends StatefulWidget {
  const Tnc_IO({Key? key}) : super(key: key);

  @override
  State<Tnc_IO> createState() => _Tnc_IOState();
}

class _Tnc_IOState extends State<Tnc_IO> {
  double heightIs = 0, widthIs = 0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:appBar('term_condition'),


      body: SafeArea(
          child: WebViewX(
            initialContent:
                'https://india1payments.in/terms-and-conditions/index.html',
            initialSourceType: SourceType.url,
            height: heightIs,
            width: widthIs,
          )),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/theme_manager.dart';

class BannerAds extends StatefulWidget {
  String? title;
  String? redirectUrl;

  BannerAds(this.title, this.redirectUrl);

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  double heightIs = 0, widthIs = 0;
  double progress = 0.0;
  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return IgnorePointer(
      ignoring: _controller.ignorePointer.value,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(widget.title),
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
                  initialUrl: widget.redirectUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (progress) => setState(() {
                    this.progress = progress / 100 as double;
                  }),
                ),
              ),
            ],
          ))),
    );
  }
}

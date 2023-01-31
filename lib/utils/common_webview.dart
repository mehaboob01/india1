import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:url_launcher/url_launcher.dart';

import '../connection_manager/ConnectionManagerController.dart';
import '../constant/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constant/theme_manager.dart';

class CommonWebView extends StatefulWidget {
  final String title, url;

  const CommonWebView({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<CommonWebView> createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  String url = "";
  double progress = 0;
  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    print('hjell ');
    print(widget.title);
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(children: [
              SafeArea(
                  child: Column(
                children: [
                  CustomAppBar(
                    heading: '${widget.title}',
                    hasLogo: true,
                    customActionIconsList: [
                      CustomActionIcons(
                          image: AppImages.bottomNavHomeSvg,
                          onHeaderIconPressed: () async {
                            Get.offNamedUntil(
                                MRouter.homeScreen, (route) => route.isFirst);
                          })
                    ],
                  ),
                  Expanded(
                    child: WebView(
                      navigationDelegate: (nav) async {
                        if (nav.url.startsWith('upi:')) {
                          openUpiApps(nav.url);
                          return NavigationDecision.prevent;
                        } else {
                          return NavigationDecision.navigate;
                        }
                      },
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      onProgress: (progress) => setState(() {
                        if (progress > 99) {
                          Future.delayed(Duration(seconds: 1)).then((value) {
                            isVisible = false;
                            setState(() {});
                          });
                        }
                        this.progress = progress / 100 as double;
                      }),
                    ),
                  ),
                ],
              )),
              Visibility(visible: isVisible, child: CircularProgressbar()),
            ])),
      ),
    );
  }

  Future<void> openUpiApps(url) async {
    log(Uri.parse(url).toString());
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}

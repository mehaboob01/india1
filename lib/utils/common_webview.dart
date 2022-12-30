import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

import '../constant/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    print('hjell ');
    print(widget.title);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.tryParse(
                    '${widget.url}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/loyalty_common_header.dart';

class Tnc_IO extends StatefulWidget {
  RxString termCondition;
  String title;
  Tnc_IO(this.termCondition, this.title, {Key? key}) : super(key: key);

  @override
  State<Tnc_IO> createState() => _Tnc_IOState();
}

class _Tnc_IOState extends State<Tnc_IO> {
  double heightIs = 0, widthIs = 0;
  double progress = 0.0;
  bool isVisible = true;

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Obx(() => IgnorePointer(
          ignoring: _controller.ignorePointer.value,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    heading: '${widget.title.tr}',
                    hasLogo: false,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: LinearProgressIndicator(
                      color: AppColors.primary,
                      backgroundColor: Colors.black38,
                      value: progress,
                    ),
                  ),
                  // Expanded(
                  //   child: InAppWebView(
                  //     initialUrlRequest: URLRequest(
                  //       url: Uri.tryParse(widget.termCondition.value),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: WebView(
                      initialUrl: widget.termCondition.value,
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
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/routes.dart';
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
                  Expanded(
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: Uri.tryParse(widget.termCondition.value),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

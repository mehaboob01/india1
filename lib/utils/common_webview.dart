import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              heading: '${widget.title}',
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

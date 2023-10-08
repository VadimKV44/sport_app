import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewWidget extends StatefulWidget {
  WebViewWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  late InAppWebViewController _webViewController;
  double progress = 0;

  Future<bool> onBackPressed() async {
    _webViewController.goBack();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: WillPopScope(
            onWillPop: onBackPressed,
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useShouldOverrideUrlLoading: true,
                      javaScriptCanOpenWindowsAutomatically: true,
                      supportZoom: false,
                    ),
                  ),
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  onCreateWindow: (controller, createWindowRequest) async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.zero,
                          content: Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: InAppWebView(
                              windowId: createWindowRequest.windowId,
                              initialOptions: InAppWebViewGroupOptions(
                                crossPlatform: InAppWebViewOptions(),
                              ),
                              onWebViewCreated: (controller) {
                                _webViewController = controller;
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return true;
                  },
                ),
                progress < 1.0
                    ? Center(
                        child: CircularProgressIndicator(
                          value: progress,
                          color: Color.fromARGB(255, 0, 167, 251),
                          strokeWidth: 3,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_user_agentx/flutter_user_agent.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key, required this.userAgent}) : super(key: key);
  String userAgent;
  @override
  _WebViewPageState createState() => new _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool loadstop = false;
  DateTime? _lastPressedAt; //上次點擊時間
  InAppWebViewController? webController;
  void initialization() async {}

  @override
  void initState() {
    print('get userAgent :${widget.userAgent}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
          onWillPop: () async {
            // if (_lastPressedAt == null ||
            //     DateTime.now().difference(_lastPressedAt!) >
            //         Duration(seconds: 1)) {
            //   //两次点击间隔超过1秒则重新计时
            //   _lastPressedAt = DateTime.now();
            //   return false;
            // }
            if (webController != null) {
              if (await webController!.canGoBack()) {
                // WebHistory? webHistory =
                //     await webController!.getCopyBackForwardList();
                webController!.goBack();
                return false;
              }
            }
            return true;
          },
          child: Scaffold(
            body: Stack(
              children: [
                loadstop == false
                    ? Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )
                    : Container(),
                Center(
                  child: InAppWebView(
                    initialUrlRequest:
                        URLRequest(url: Uri.parse('https://sulitgaming.com/')),
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                        useHybridComposition: true,
                        domStorageEnabled: true,
                        databaseEnabled: true,
                      ),
                      crossPlatform: InAppWebViewOptions(
                          userAgent: widget.userAgent.toLowerCase(),
                          transparentBackground: true,
                          mediaPlaybackRequiresUserGesture: false,
                          allowUniversalAccessFromFileURLs: true,
                          javaScriptCanOpenWindowsAutomatically: true,
                          preferredContentMode:
                              UserPreferredContentMode.MOBILE),
                    ),
                    onLoadStart:
                        (InAppWebViewController? controller, Uri? url) {},
                    onLoadStop: (InAppWebViewController? controller, Uri? url) {
                      setState(() {
                        loadstop = true;
                      });
                      SmartDialog.dismiss();
                    },
                    onWebViewCreated: (InAppWebViewController? controller) {
                      webController = controller;
                      setState(() {});
                      SmartDialog.showLoading();
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}

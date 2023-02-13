import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_user_agentx/flutter_user_agent.dart';
import 'package:flutter_webview/splash.dart';
import 'package:flutter_webview/webview.dart';

// Main
String userAgent = '';

Future<void> main() async {
  runApp(MyApp());
  getUserAgent();
}

String skipLastChar(String text) {
  return text.substring(0, max(0, text.length - 1));
}

getUserAgent() async {
  userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
  print(skipLastChar(userAgent));
  userAgent = skipLastChar(userAgent) +
      "; " +
      "Version_" +
      await FlutterUserAgent.getProperty('applicationVersion') +
      ")";
  // String test = await FlutterUserAgent.getProperty('applicationVersion');
  print(userAgent);
}

// MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: SplashPage(),
          );
        }

        // Main
        else {
          return MaterialApp(
            home: WebViewPage(
              userAgent: userAgent,
            ),
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
          );
        }
      },
    );
  }
}

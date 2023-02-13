import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Container(
            color: Colors.black,
            child: Image.asset("assets/images/splash.png", fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:e_visiting_card/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/card.png',
                width: 300, height: 300, fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "E-Visiting Card",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../auth/wrapper.dart'; // Import the next screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change to match your theme
      body: Center(
        child: Text(
          "SmartInvest.",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.purple),
        ),
      ),
    );
  }
}

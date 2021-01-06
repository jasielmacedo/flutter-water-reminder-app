import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue.shade50,
                  Colors.lightBlue.shade300,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            child: Center(
              child: Container(
                height: 150,
                child: SvgPicture.asset(
                  'assets/images/waterlogo.svg',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

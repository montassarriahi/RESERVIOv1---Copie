import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reserviov1/constants/constants.dart';
import 'package:reserviov1/screens/onboarding/onboarding_1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(context as BuildContext,
            MaterialPageRoute(builder: (context) => OnboardingOne())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: Safepadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/logo.png"),
              height: 200,
              width: 200,
            )
          ],
        ),
      ),
    ));
  }
}

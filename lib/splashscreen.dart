import 'dart:async';

import 'package:ezys/home_screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/ezye sc.gif',
          height: 250,
          width: 250,
        ),
      ),
    );
  }

  Future<void> navigateFunction() async {
    Timer(const Duration(milliseconds: 2600), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }
}

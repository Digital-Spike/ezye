import 'dart:async';


import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
      //backgroundColor: Color(0xffF5E6C2),
      body: Center(
        child: SvgPicture.asset(
          'assets/logof.svg',
          height: 150, // Adjust the height as needed
          width: 150, // Adjust the width as needed
        ),
      ),
    );
  }

  Future<void> navigateFunction() async {
    
    Timer(const Duration(milliseconds: 2800), () {
      
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
});} 
  }
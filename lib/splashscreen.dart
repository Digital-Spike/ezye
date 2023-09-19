import 'dart:async';


import 'package:ezys/homescreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController controller;
  @override
  void initState() {
     navigateFunction();
    super.initState();
    controller = VideoPlayerController.asset('assets/ezyesplash.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    controller.setLooping(false);
    controller.play();
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xffF5E6C2),
      body:  VideoPlayer(controller),
    );
  }

  Future<void> navigateFunction() async {
    
    Timer(const Duration(milliseconds: 2000), () {
      
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
});} 
  }

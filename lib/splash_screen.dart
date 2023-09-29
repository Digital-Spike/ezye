import 'dart:async';

import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/home_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> listener;
  @override
  void initState() {
    navigateFunction();
    super.initState();
  }
   @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/EZYE SS.gif',
          height: 250,
          width: 250,
        ),
      ),
    );
  }

  Future<void> navigateFunction() async {
    Timer(const Duration(milliseconds: 2650), () {
       listener =
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user ==
                  null /*||
            ((user.email ?? "").isNotEmpty && !user.emailVerified)*/
              ) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else{
      Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()),
            );
    }
    });
  });
}
}
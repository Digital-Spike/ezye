
import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/Auth_screen/signup_screen.dart';
import 'package:ezys/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Auth_screen/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ezye',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        // brightness: Brightness.light,
        fontFamily: 'Proxima Nova',
      ),
      home: const SplashScreen(),
    );
  }
}

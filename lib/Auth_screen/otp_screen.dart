import 'dart:async';

import 'package:ezye/Auth_screen/testlogin.dart';
import 'package:ezye/home_screens/home_screen.dart';
import 'package:ezye/home_screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPScreen extends StatefulWidget {
  final String number;
  const OTPScreen({super.key, required this.number});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with CodeAutoFill {
  String verificationIdentity = '';
  String otpCode = '';
  @override
  void initState() {
    startTimer();
    listenForCode();
    getOtp(widget.number);
    super.initState();
  }

  @override
  Future<void> dispose() async {
    _timer.cancel();
    cancel();
    unregisterListener();
    super.dispose();
  }

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  late final ColorBuilder strokeColorBuilder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to EZYE',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffBDC1CA)),
            ),
            const Text(
              'Discover Fashion, Your Way!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            PinFieldAutoFill(
                decoration: BoxLooseDecoration(
                    gapSpace: 10,
                    strokeWidth: 1,
                    radius: const Radius.circular(12),
                    strokeColorBuilder:
                        const FixedColorBuilder(Color(0xffBDC1CA))),
                currentCode: otpCode,
                enableInteractiveSelection: true,
                onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  setState(() {
                    otpCode = code!;
                  });
                  if (otpCode.length == 6) _timer.cancel();
                  if (code?.length == 6) {}
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('00:$_start')],
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                  text:
                      'A one-time password has been sent to your mobile number ${widget.number}. ',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7C7D85)),
                  children: const [
                    TextSpan(
                        text: ' Need to change it?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff040707)))
                  ]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            if (otpCode.length == 6)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff040707),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: const Size(double.infinity, 56)),
                  onPressed: () {
                    verifyPhoneNumber(context: context, otp: otpCode);
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
            if (otpCode.length != 6)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffBDC1CA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: const Size(double.infinity, 56)),
                  onPressed: () {
                    setState(() {
                      if (code?.length != 6) ;
                    });
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
          ],
        ),
      )),
    );
  }

  Future<void> verifyPhoneNumber({context, otp}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIdentity, smsCode: otp);
      User? user = (await auth.signInWithCredential(credential)).user;
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TestLogin()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Invalid OTP',
          style: TextStyle(fontFamily: 'Nunito'),
        )),
      );
      print('Error ${e.toString()}');
    }
  }

  Future<void> getOtp(String number) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Invalid Phone Number',
                      style: TextStyle(fontFamily: 'Nunito'))),
            );
          }
          print('The Error is ${e.code}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          verificationIdentity = verificationId;
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}

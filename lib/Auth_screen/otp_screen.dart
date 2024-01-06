import 'dart:async';
import 'dart:convert';

import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/home_screens/main_screen.dart';
import 'package:ezye/model/user.dart';
import 'package:ezye/profilescreens/create_profile.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
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
  User? user;

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
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: RichText(
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
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdentity, smsCode: otp);

    UserCredential userCredential = await auth.signInWithCredential(credential);

    bool isUserExist = await getUser(userCredential.user?.uid ?? '');
    if (!isUserExist && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateProfile(),
        ),
      );
      return;
    }

    if (userCredential.user?.uid != null) {
      Fluttertoast.showToast(
        msg: "You are logged in successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: "your login is failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<bool> getUser(String userId) async {
    try {
      var getUserUrl = Uri.parse('${ApiService.url}getUser.php');
      var reqBody = {"userId": userId};

      var response = await http.post(getUserUrl, body: reqBody);
      if (response.statusCode == 200) {
        Map<String, dynamic> user =
            (jsonDecode((response.body).toString().replaceAll('connected', ''))
                    as List)
                .firstOrNull;
        SessionObject.user = UserModel.fromJson(user);
        await getCartItems();
        return (jsonDecode(
                        (response.body).toString().replaceAll('connected', ''))
                    as List)
                .first['userId'] !=
            null;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> getCartItems() async {
    try {
      var productUrl = Uri.parse('${ApiService.url}getCartDetails.php');
      var response = await http
          .post(productUrl, body: {"cartId": SessionObject.user.cartId ?? ""});

      if (response.statusCode == 200) {
        SessionObject.user.cartItemCount =
            (json.decode(response.body) as List).length.toString();
      }
      return true;
    } catch (error) {
      print('Error: $error');
    }
    return false;
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

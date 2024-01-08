// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:ezye/Auth_screen/otp_screen.dart';
import 'package:ezye/home_screens/home_screen.dart';
import 'package:ezye/home_screens/main_screen.dart';
import 'package:ezye/settings/terms_and_conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  var phoneController = '';
  TextEditingController countryController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    countryController.text = "+91";
    SmsAutoFill().listenForCode;
    super.initState();
    checkCurrentUser(); // Check if the user is already logged in
  }

  void checkCurrentUser() async {
    String? signature = await PhonePePaymentSdk.getPackageSignatureForAndroid();
    print("&***************************************");
    print(signature);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  String phoneError = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Welcome to EZYE',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffBDC1CA)),
                    ),
                    if (Platform.isIOS)
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 36),
                              backgroundColor: const Color(0xff040707),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen(
                                          indeX: 0,
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'SKIP',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset(
                                'assets/svg/arrow.svg',
                                width: 22,
                                color: Colors.white,
                              )
                            ],
                          ))
                  ],
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
                  'Mobile Number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 1.5, color: const Color(0xffE8E9EE))),
                      child: const Text(
                        '+91',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        decoration: InputDecoration(
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff7C7D85)),
                            hintText: 'Enter your mobile number',
                            isDense: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    width: 0.1, color: Colors.white))),
                        onChanged: (value) {
                          setState(() {
                            phoneController = value;
                          });
                          if (phoneController.length == 10) {
                            setState(() {
                              FocusScope.of(context).unfocus();
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
                Center(
                  child: Text(
                    phoneError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                      text: 'By clicking',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff7C7D85),
                          fontWeight: FontWeight.w400),
                      children: [
                        const TextSpan(
                            text: ' "GET OTP" ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff040707))),
                        const TextSpan(
                            text: 'you confirm your acceptance of these '),
                        TextSpan(
                            text: 'terms and conditions.',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TermsAndConditions()));
                              },
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff040707)))

                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TermsAndConditions()));*/
                      ]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                if (phoneController.length == 10)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff040707),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(double.infinity, 56)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPScreen(
                                    number: countryController.text +
                                        phoneController)));
                      },
                      child: const Text(
                        'Get OTP',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                if (phoneController.length != 10)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffBDC1CA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(double.infinity, 56)),
                      onPressed: () {
                        setState(() {
                          phoneError = "Please Enter valid mobile Number";
                        });
                      },
                      child: const Text(
                        'Get OTP',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

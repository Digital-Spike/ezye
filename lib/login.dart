
import 'package:ezys/home.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? phoneNumber;
  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '* Log in using Mobile Number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 10),
            IntlPhoneField(
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                setState(() {
                  phoneNumber = phone.completeNumber;
                  isSignIn = (phone.number.length == 10) ? true : false;
                });
              },
              onCountryChanged: (country) {
                if (country.dialCode != "91") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Currently our service available only in India')),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              '* Enter OTP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    height: 50,
                    width: 220,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                SizedBox(width: 20),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      
                    },
                    child: Text(
                      'Get OTP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(height: 40),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        minimumSize: Size(380, 50),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}

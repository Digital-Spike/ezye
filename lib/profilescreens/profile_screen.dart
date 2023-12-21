import 'dart:convert';

import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/custom_widgets/profile_button.dart';
import 'package:ezye/paymentScreens/wallet_screen.dart';
import 'package:ezye/profilescreens/addresses_screen.dart';
import 'package:ezye/profilescreens/editprofile.dart';
import 'package:ezye/profilescreens/help_and_support.dart';
import 'package:ezye/profilescreens/my_orders.dart';
import 'package:ezye/profilescreens/refer_earn.dart';
import 'package:ezye/profilescreens/settings.dart';
import 'package:ezye/profilescreens/wishlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;
  final user = FirebaseAuth.instance.currentUser;
  late String? _phone;
  String? name, phone;
  @override
  void initState() {
    super.initState();
    getUser();
    _phone = user?.phoneNumber;
    checkLoginStatus(); // Call the function to fetch carousel data
  }

  void checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    setState(() {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoggedIn == false)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: width / 1.5),
                      SvgPicture.asset('assets/svg/cloud.svg'),
                      const SizedBox(height: 20),
                      const Text(
                        'To access your account, please log in or create a new account.',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff7C7D85)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minimumSize: const Size(208, 56)),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
              if (isLoggedIn == true)
                Column(
                  children: [
                    Container(
                      height: width / 1.3,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          color: const Color(0xff040707)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Container(
                            height: 86,
                            width: 86,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage('assets/png/user.png')),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    width: 1.5,
                                    color: const Color(0xffE8E9EE))),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            name != null ? name.toString() : 'Welcome',
                            style: const TextStyle(
                                color: Color(0xff7C7D85),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _phone ?? '',
                            style: const TextStyle(
                                color: Color(0xff7C7D85),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(112, 28),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfile()));
                              },
                              child: const Text(
                                'EDIT PROFILE',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          CustomButton(
                              title1: 'Addresses',
                              svgPath: 'assets/svg/location.svg',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Addresses()));
                              }),
                          devider,
                          CustomButton(
                              title1: 'Wishlist',
                              svgPath: 'assets/svg/heart.svg',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WishListScreen()));
                              }),
                          devider,
                          CustomButton(
                              title1: 'My Wallet',
                              svgPath: 'assets/svg/wallet.svg',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WalletPage()));
                              }),
                          devider,
                          CustomButton(
                              title1: 'My Orders',
                              svgPath: 'assets/svg/transaction.svg',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyOrdersScreen()));
                              }),
                          devider,
                          CustomButton(
                              title1: 'Settings',
                              svgPath: 'assets/svg/settings.svg',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsPage()));
                              }),
                          devider,
                          CustomButton(
                              title1: 'Help & Support',
                              svgPath: 'assets/svg/helpandsupport.svg',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HelpAndSupport()));
                              }),
                          devider,
                          CustomButton(
                              title1: 'Refer & Earn',
                              svgPath: 'assets/svg/share.svg',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReferAndEarn()));
                              }),
                          devider,
                          CustomButton(
                              title1: 'Logout',
                              svgPath: 'assets/svg/logout.svg',
                              onPressed: _showDialog),
                          devider
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }

  void getUser() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String apiUrl = "https://ezys.in/customerApp/getUser.php";
    var response = await http.post(Uri.parse(apiUrl), body: {
      "userId": userId,
    });
    var jsondata =
        json.decode((response.body).toString().replaceAll('connected', ''));
    print(jsondata);
    setState(() {
      name = jsondata[0]['name'];
      phone = jsondata[0]['mobile'];
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            insetPadding: const EdgeInsets.all(30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Center(
              child: Text(
                'Are you sure you want to\nlog out?.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            actionsPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: const Size(154, 56)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: const Size(154, 56)),
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          });
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  )
                ],
              )
            ],
          );
        });
  }
}

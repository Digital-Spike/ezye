import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/custom_widgets/dashed_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({super.key});

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  bool isLoggedIn = false;
  void checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            'Refer & Earn',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
        ),
        body: Column(
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
                      style: TextStyle(fontSize: 14, color: Color(0xff7C7D85)),
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        color: Color(0xff040707)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Invite Friends & Earn Rewards',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Invite your friends and earn rewards when they join using your referral code.',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 55),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 1.5,
                                    color: const Color(0xffE8E9EE))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your referral code',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff7C7D85)),
                                    ),
                                    Text(
                                      'XKGBKJ84513DFBKJ8',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor: Colors.white,
                                        minimumSize: const Size(92, 34)),
                                    onPressed: () async {
                                      await Clipboard.setData(
                                          const ClipboardData(
                                        text: "XKGBKJ84513DFBKJ8",
                                      ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset('assets/svg/copy.svg'),
                                        const SizedBox(width: 5),
                                        const Text('COPY')
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: DashLine(
                                color: Color(0xffBDC1CA),
                              ),
                            ),
                            Text(
                              '   OR   ',
                              style: TextStyle(
                                color: Color(0xffBDC1CA),
                              ),
                            ),
                            Expanded(
                                child: DashLine(
                              color: Color(0xffBDC1CA),
                            ))
                          ],
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Share this code with friends to earn rewards when they join.',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                minimumSize: const Size(double.infinity, 56)),
                            onPressed: () async {
                              final box =
                                  context.findRenderObject() as RenderBox?;
                              await Share.share(
                                'XKGBKJ84513DFBKJ8',
                                sharePositionOrigin:
                                    box!.localToGlobal(Offset.zero) & box.size,
                              );
                            },
                            child: const Text(
                              'Share Link',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ));
  }
}

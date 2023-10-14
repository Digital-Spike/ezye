import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/profile_button.dart';
import 'package:ezys/home_screens/main_screen.dart';
import 'package:ezys/orderscreens/myorder_screen.dart';
import 'package:ezys/paymentScreens/payment_screen.dart';
import 'package:ezys/profilescreens/editprofile.dart';
import 'package:ezys/profilescreens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: buttonColor),
          title: const Text(
            'Profile',
            style: apptitle,
          ),
          centerTitle: true,
        ),
        mainChild: Container(
          height: double.infinity,
          color: bgcolor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Stack(
                    children: [
                      const Center(
                        child: CircleAvatar(
                          minRadius: 55,
                          child: Icon(
                            CupertinoIcons.person,
                            size: 60,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 200,
                          right: 120,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfile()));
                            },
                            child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                    color: Colors.grey,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  'assets/icons/Edit (1).svg',
                                  height: 20,
                                  width: 20,
                                )),
                          ))
                    ],
                  ),
                ),
                const Text(
                  'User name',
                  style: title,
                ),
                const SizedBox(height: 35),
                CustomButton(
                    title1: 'Payment Methods',
                    svgPath: 'assets/icons/Card.svg',
                    trailingIcon: CupertinoIcons.forward,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentPage(
                                    address: '',
                                    totalAmount: '',
                                  )));
                    }),
                divider,
                CustomButton(
                    title1: 'My Orders',
                    svgPath: 'assets/icons/Order.svg',
                    trailingIcon: CupertinoIcons.forward,
                    onPressed: () {
                      if (isLoggedIn) {
                        // User is logged in, navigate to the payment page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderPage()));
                      } else {
                        // User is not logged in, show the login dialog
                        _showLoginDialog1();
                      }
                    }),
                divider,
                CustomButton(
                    title1: 'Settings',
                    svgPath: 'assets/icons/Settings (1).svg',
                    trailingIcon: CupertinoIcons.forward,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
                    }),
                divider,
                CustomButton(
                    title1: 'Help Center',
                    svgPath: 'assets/icons/Help Center.svg',
                    trailingIcon: CupertinoIcons.forward,
                    onPressed: () {}),
                divider,
                CustomButton(
                    title1: 'Privacy Policy',
                    svgPath: 'assets/icons/Privacy Policy.svg',
                    trailingIcon: CupertinoIcons.forward,
                    onPressed: () {}),
                divider,
                CustomButton(
                    title1: 'Invite Friends',
                    svgPath: 'assets/icons/Invite.svg',
                    trailingIcon: CupertinoIcons.forward,
                    onPressed: () async {
                      if (isLoggedIn) {
                        // User is logged in, navigate to the payment page
                        final box = context.findRenderObject() as RenderBox?;
                        await Share.share(
                          'check out this app',
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      } else {
                        // User is not logged in, show the login dialog
                        _showLoginDialog();
                      }
                    }),
                divider,
                CustomButton(
                    title1: 'Log out',
                    svgPath: 'assets/icons/logout 2.svg',
                    trailingIcon: CupertinoIcons.forward,
                    onPressed: () {
                      if (isLoggedIn) {
                        // User is logged in, navigate to the payment page

                        showModalBottomSheet(
                          elevation: 5,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          context: context,
                          builder: (context) => Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SizedBox(
                              height: 200,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Logout',
                                      style: title,
                                    ),
                                    const SizedBox(height: 10),
                                    divider,
                                    const SizedBox(height: 10),
                                    Text(
                                      'Are you sure you want to log out?',
                                      style: content1,
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  minimumSize: const Size(
                                                      double.infinity, 50),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: subtitle1,
                                              )),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor: buttonColor,
                                                  minimumSize: const Size(
                                                      double.infinity, 50),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              onPressed: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Yes, Logout',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        // User is not logged in, show the login dialog
                        _showLoginDialog2();
                      }
                    }),
              ],
            ),
          ),
        ));
  }

  void _showLoginDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:
              const Text('Login Required!', style: TextStyle(color: indicator)),
          content: const Text('You need to log in to Invite Friends.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Log In',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }

  void _showLoginDialog1() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Login Required!',
            style: TextStyle(color: indicator),
          ),
          content: const Text('You need to log in to Check Your Orders.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Log In',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }

  void _showLoginDialog2() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Login Required!',
            style: TextStyle(color: indicator),
          ),
          content: const Text('You need to log in to First.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Log In',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }
}

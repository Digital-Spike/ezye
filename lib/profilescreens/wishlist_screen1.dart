import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<dynamic> imageList = [
    'assets/png/cloth.png',
    'assets/png/pant.png',
    'assets/png/shorts.png',
    'assets/png/shirt.png',
  ];
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
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Wishlist',
          style: apptitle,
        ),
        centerTitle: true,
        leading: const BackButton(color: buttonColor),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1,
              color: const Color(0xffE8E9EE),
            )),
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
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: GridView.builder(
                    itemCount: imageList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 1.9,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemBuilder: ((context, int) {
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset(
                                'assets/png/cloth.png',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Colors.black),
                                  child: const Text(
                                    'EZYE',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                SvgPicture.asset('assets/svg/redheart.svg')
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Men Blue Washed Denim Jacket',
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Text(
                                  '₹ 2199',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Color(0xff7C7D85),
                                      fontSize: 14),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  '₹ 2000',
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: const Color(0xff00CA14)),
                                  child: const Text(
                                    '10% Off',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    })),
              ),
            ),
        ],
      ),
    );
  }
}

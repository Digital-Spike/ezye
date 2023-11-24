import 'package:animate_do/animate_do.dart';
import 'package:ezye/home_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({super.key});

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  late AnimationController animateController;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
        return Future.value(true);
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/orderconfirm.svg',
              fit: BoxFit.cover,
            ),
            Positioned(
                left: MediaQuery.of(context).size.width / 8,
                top: MediaQuery.of(context).size.height / 4,
                child: BounceInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Image.asset(
                    'assets/png/Ezyecoin.png',
                    height: 180,
                  ),
                )),
            Positioned(
                left: MediaQuery.of(context).size.width / 2.9,
                top: MediaQuery.of(context).size.height / 2.1,
                child: BounceInDown(
                  delay: const Duration(milliseconds: 100),
                  child: Image.asset(
                    'assets/png/Ezyecoin.png',
                    height: 80,
                  ),
                )),
            Positioned(
                left: MediaQuery.of(context).size.width / 1.8,
                top: MediaQuery.of(context).size.height / 2.8,
                child: BounceInDown(
                  delay: const Duration(milliseconds: 150),
                  child: Image.asset(
                    'assets/png/Ezyecoin.png',
                    height: 140,
                  ),
                )),
            Positioned(
                left: MediaQuery.of(context).size.width / 20,
                top: MediaQuery.of(context).size.height / 4.8,
                child: FadeIn(
                    delay: const Duration(milliseconds: 500),
                    child: SvgPicture.asset('assets/svg/Stars.svg'))),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Congratulations! Your order placed & You Earned 50 EZYE Coins.',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.white,
                        minimumSize: const Size(250, 56)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()));
                    },
                    child: const Text(
                      'Explore',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

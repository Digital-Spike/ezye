import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/home_screens/main_screen.dart';
import 'package:ezye/paymentScreens/transaction_screen.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Wallet',
            style: apptitle,
          ),
          centerTitle: true,
        ),
        mainChild: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 100,
              color: buttonColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/EZYE Coin black.png',
                        height: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${SessionObject.user.walletBalance ?? 0}',
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Total Ezye Coins balance',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransactionPage()));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ezye Coins History',
                            style: title1,
                          ),
                          Icon(
                            CupertinoIcons.forward,
                            color: indicator,
                          )
                        ],
                      ),
                      Text(
                        'You can Check all Your Ezye Coins Earn and Spent History here',
                        style: content,
                      )
                    ]),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Frequently Asked Questions',
                style: title,
              ),
            ),
            const SizedBox(height: 10),
            const ExpansionTile(
              expandedAlignment: Alignment.bottomLeft,
              tilePadding: EdgeInsets.symmetric(horizontal: 10),
              iconColor: Colors.black,
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              childrenPadding: EdgeInsets.symmetric(horizontal: 10),
              title: Text(
                'What is Ezye Coins?',
                style: subtitle,
              ),
              children: [
                Text(
                    '1. Ezey coins are the reward which you will get for purchase from Ezey app'),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ],
        ));
  }
}

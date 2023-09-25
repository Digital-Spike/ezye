import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/home_screens/main_screen.dart';
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
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
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey.shade400),
                color: Colors.white,
              ),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                  ]),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Frequently Asked Questions',
                style: title,
              ),
            ),
            const SizedBox(height: 10),
            const ExpansionTile(
              iconColor: Colors.black,
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              childrenPadding: EdgeInsets.all(10),
              title: Text(
                'What is Ezye Coins?',
                style: subtitle,
              ),
              children: [
                Text(
                    '1. Find Best Talents & Best JObs,Enter your mobile no to sign up')
              ],
            )
          ],
        ));
  }
}

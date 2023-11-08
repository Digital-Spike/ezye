import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CateGories extends StatefulWidget {
  const CateGories({super.key});

  @override
  State<CateGories> createState() => _CateGoriesState();
}

class _CateGoriesState extends State<CateGories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1,
              color: const Color(0xffE8E9EE),
            )),
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Categories',
          style: apptitle,
        ),
        centerTitle: true,
        actions: [
          SvgPicture.asset('assets/svg/bag.svg'),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 115,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/png/women.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 115,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/png/mens.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 115,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/png/boys.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 115,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/png/girls.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 115,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                'assets/png/babies.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

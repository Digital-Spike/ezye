import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<String> imgList = ['assets/png/man.png'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.2)),
              child: const BackButton()),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.white.withOpacity(0.2)),
                onPressed: () {},
                child: SvgPicture.asset(
                  'assets/svg/heart.svg',
                  height: 24,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.white.withOpacity(0.2)),
                onPressed: () {},
                child: SvgPicture.asset('assets/svg/cart.svg')),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.9,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Image.asset(
                          'assets/png/man.png',
                          fit: BoxFit.fill,
                        ));
                  },
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width / 2.5,
                  bottom: 10,
                  child: DotsIndicator(dotsCount: 4))
            ],
          ),
          Text('data')
        ],
      )),
    );
  }
}

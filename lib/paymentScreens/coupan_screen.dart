import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoupanPage extends StatefulWidget {
  const CoupanPage({super.key});

  @override
  State<CoupanPage> createState() => _CoupanPageState();
}

class _CoupanPageState extends State<CoupanPage> {
  void copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Coupons',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(width: 1.5, color: const Color(0xffE8E9EE))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/coupan.svg'),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter coupon code',
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Color(0xff7C7D85))),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.black,
                          minimumSize: const Size(130, 34)),
                      onPressed: () {},
                      child: const Text(
                        'APPLY COUPON',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Coupons for you',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        SvgPicture.asset('assets/svg/coupon.svg'),
                        const Positioned(
                            top: 45,
                            left: 35,
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  'FLAT500',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ))),
                        Positioned(
                            top: 15,
                            left: 100,
                            child: Container(
                              height: 160,
                              width: MediaQuery.of(context).size.width / 1.7,
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/png/kotak.png'),
                                      const SizedBox(width: 5),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'FLAT ₹500 Off',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Get ₹500 OFF using Kotak bank Cards',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Color(0xff7C7D85)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Lorem ipsum dolor sit amet consectetur. Egestas augue vel nunc scelerisque adipiscing quis vel. Nisi amet malesuada nunc id dolor. ',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff7C7D85)),
                                    textAlign: TextAlign.justify,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          backgroundColor: Colors.black,
                                          minimumSize: const Size(130, 34)),
                                      onPressed: () {},
                                      child: const Text(
                                        'APPLY COUPON',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ))
                                ],
                              ),
                            ))
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

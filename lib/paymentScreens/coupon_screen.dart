import 'dart:convert';

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/coupon.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  void copyToClipboard(String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
  }

  late Future futureCoupon;
  List<Coupon> couponList = [];

  @override
  void initState() {
    futureCoupon = getCoupon();
    super.initState();
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
      body: FutureBuilder<void>(
        future: futureCoupon,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1.5, color: const Color(0xffE8E9EE))),
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
                                          fontSize: 14,
                                          color: Color(0xff7C7D85))),
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
                            ),
                          ),
                        ],
                      ),
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
                      itemCount: couponList.length,
                      itemBuilder: (context, index) {
                        Coupon coupon = couponList[index];

                        return Stack(
                          children: [
                            SvgPicture.asset('assets/svg/coupon.svg'),
                            Positioned(
                              top: 45,
                              left: 35,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  coupon.code ?? "",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                            ),
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
                                    ListTile(
                                      leading:
                                          Image.asset('assets/png/kotak.png'),
                                      title: Text(
                                        coupon.code ?? "",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      subtitle: Text(
                                        coupon.description ?? "",
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff7C7D85)),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            backgroundColor: Colors.black,
                                            minimumSize: const Size(130, 34)),
                                        onPressed: () {
                                          Navigator.pop(context, coupon);
                                        },
                                        child: const Text(
                                          'APPLY ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return const Text("Something wrong please try again later.");
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future getCoupon() async {
    try {
      var url = Uri.parse('${ApiService.url}getCoupons.php');
      var response = await http.post(url, body: {});
      if (response.statusCode == 200) {
        couponList =
            (json.decode((response.body).toString().replaceAll('connected', ''))
                    as List)
                .map((item) => Coupon.fromJson(item))
                .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

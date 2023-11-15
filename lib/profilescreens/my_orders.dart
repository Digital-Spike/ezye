import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/orderscreens/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Orders',
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color(0xffE8E9EE).withOpacity(0.3)),
              child: const Text('This Month'),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(width: 0.5, color: const Color(0xffE8E9EE))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ORD02134567',
                          ),
                          Text(
                            '07 Oct 2023  05:23 PM',
                            style: TextStyle(color: Color(0xffBDC1CA)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/checkgreen.svg'),
                          const SizedBox(width: 5),
                          const Text('Order Placed')
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xffE8E9EE).withOpacity(0.3)),
                    child: const Text(
                      'Products(3)',
                      style: TextStyle(color: Color(0xff7C7D85)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      height: 80,
                                      width: 60,
                                      child: Image.asset(
                                        'assets/png/cloth.png',
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                      child: const Text(
                                        'Men Blue Washed Denim Jacket men Blue',
                                        style: TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'XL',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xffBDC1CA)),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Column(
                                          children: [
                                            Text(
                                              '₹ 2,199',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xffBDC1CA),
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            Text(
                                              '₹2,000',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 2),
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color(0xff00CA14)),
                                          child: const Text(
                                            '10% Off',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize: const Size(double.infinity, 38)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderDetail()));
                      },
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

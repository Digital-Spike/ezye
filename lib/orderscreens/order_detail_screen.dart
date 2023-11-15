import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/orderscreens/cancel_order.dart';
import 'package:ezye/orderscreens/return_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool popMenu = false;
  bool returnOrder = false;
  bool orderPlaced = true;
  bool reurnRefunded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Orders Details',
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
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                popMenu = !popMenu;
                print(popMenu);
              });
            },
            child: Container(
                width: 46,
                height: 46,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffE8E9EE).withOpacity(0.3)),
                child: SvgPicture.asset(
                  popMenu ? 'assets/svg/clear.svg' : 'assets/svg/popmenu.svg',
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      if (returnOrder == true)
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/spinner.svg'),
                            const SizedBox(width: 5),
                            const Text('Return Requested')
                          ],
                        ),
                      if (orderPlaced == true)
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/checkgreen.svg'),
                            const SizedBox(width: 5),
                            const Text('Order Placed'),
                          ],
                        ),
                      if (reurnRefunded == true)
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/checkgreen.svg'),
                            const SizedBox(width: 5),
                            const Text('Returned & Refunded')
                          ],
                        )
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (returnOrder == true)
                    if (reurnRefunded == true)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color:
                                    const Color(0xffE8E9EE).withOpacity(0.3)),
                            child: const Text(
                              'Products(3)',
                              style: TextStyle(color: Color(0xff7C7D85)),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.6,
                                              child: const Text(
                                                'Men Blue Washed Denim Jacket men Blue',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'SIZE: XL',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xffBDC1CA)),
                                            ),
                                            const SizedBox(height: 5),
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
                                                          color:
                                                              Color(0xffBDC1CA),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                    Text(
                                                      '₹2,000',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 2),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: const Color(
                                                          0xff00CA14)),
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
                          const SizedBox(height: 15),
                          const Text('Pickup Location',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 15),
                          const Text(
                            '392, 1st Floor, Jnana Marga, 1st Stage, Siddhartha Layout, Mysuru, Karnataka 570011',
                            style: TextStyle(color: Color(0xff7C7D85)),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Refund Details',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Refundable Amount',
                                style: TextStyle(color: Color(0xff7C7D85)),
                              ),
                              Text(
                                '₹ 2,000.00',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Refund Status',
                                style: TextStyle(color: Color(0xff7C7D85)),
                              ),
                              Text(
                                'Pending',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffF3A100)),
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                  if (reurnRefunded == true)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color(0xffE8E9EE).withOpacity(0.3)),
                          child: const Text(
                            'Products(3)',
                            style: TextStyle(color: Color(0xff7C7D85)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 5),
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            child: const Text(
                                              'Men Blue Washed Denim Jacket men Blue',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'SIZE: XL',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffBDC1CA)),
                                          ),
                                          const SizedBox(height: 5),
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
                                                        color:
                                                            Color(0xffBDC1CA),
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  Text(
                                                    '₹2,000',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 2),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color(
                                                        0xff00CA14)),
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
                        const SizedBox(height: 15),
                        const Text('Pickup Location',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 15),
                        const Text(
                          '392, 1st Floor, Jnana Marga, 1st Stage, Siddhartha Layout, Mysuru, Karnataka 570011',
                          style: TextStyle(color: Color(0xff7C7D85)),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Refund Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Refundable Amount',
                              style: TextStyle(color: Color(0xff7C7D85)),
                            ),
                            Text(
                              '₹ 2,000.00',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Refund Status',
                              style: TextStyle(color: Color(0xff7C7D85)),
                            ),
                            Text(
                              'Paid',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff00CA14)),
                            )
                          ],
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xffE8E9EE).withOpacity(0.3)),
                    child: const Text(
                      'Products(2)',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        height: 100,
                                        width: 80,
                                        child: Image.asset(
                                          'assets/png/cloth.png',
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  const SizedBox(width: 5),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            child: const Text(
                                              'Men Blue Washed Denim Jacket men Blue',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const Text(
                                            'SIZE: XL',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xffBDC1CA)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 5),
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
                            ),
                          );
                        }),
                  ),
                  const Text(
                    'Payment Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(color: Color(0xff7C7D85)),
                      ),
                      Text('Phone Pay')
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Status',
                        style: TextStyle(color: Color(0xff7C7D85)),
                      ),
                      Text(
                        'Paid',
                        style: TextStyle(color: Color(0xff00CA14)),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Delivery Location',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '392, 1st Floor, Jnana Marga, 1st Stage, Siddhartha Layout, Mysuru, Karnataka 570011',
                    style: TextStyle(color: Color(0xff7C7D85)),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Billing Details',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total MRP',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
                      ),
                      Text(
                        '₹ 12,894.00',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff00CA14)),
                      ),
                      Text(
                        '- ₹ 8,976.00',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff00CA14)),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coupon Discount',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
                      ),
                      Text(
                        '-',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'EZYE Coins',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff00CA14)),
                      ),
                      Text(
                        '- ₹ 100.00',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff00CA14)),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Charges',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
                      ),
                      Text(
                        '₹ 150.00',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
                      ),
                      Text(
                        '₹ 320.00',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xffE8E9EE).withOpacity(0.3)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
                        ),
                        Text(
                          '₹ 3,818.00',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          side: const BorderSide(
                              width: 2, color: Color(0xffF30000))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CancelOrder()));
                      },
                      child: const Text(
                        'Cancel Order',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffF30000)),
                      )),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            if (popMenu)
              Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 2.2,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReturnOrder()));
                          },
                          child: const Text(
                            'Return Order',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: devider,
                        ),
                        MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            'Download Invoice',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}

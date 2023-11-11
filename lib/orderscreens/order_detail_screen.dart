import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/orderscreens/cancel_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool popMenu = false;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffE8E9EE).withOpacity(0.3)),
              child: PopupMenuButton(
                  onOpened: () {
                    setState(() {
                      popMenu = !popMenu;
                    });
                  },
                  icon: SvgPicture.asset(popMenu
                      ? 'assets/svg/popmenu.svg'
                      : 'assets/svg/clear.svg'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                child: const Text(
                                  'Return Order',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              devider
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: MaterialButton(
                            onPressed: () {},
                            child: const Text(
                              'Download Invoice',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      ]),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: ListView.builder(
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
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 80,
                                  width: 60,
                                  child: Image.asset(
                                    'assets/png/cloth.png',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(width: 5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
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
                                      fontSize: 12, color: Color(0xffBDC1CA)),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Column(
                                      children: [
                                        Text(
                                          '₹ 2,199',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xffBDC1CA),
                                              decoration:
                                                  TextDecoration.lineThrough),
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
                                            fontSize: 12, color: Colors.white),
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
                    style: TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
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
                    style: TextStyle(fontSize: 16, color: Color(0xff00CA14)),
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
                    style: TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
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
                    style: TextStyle(fontSize: 16, color: Color(0xff00CA14)),
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
                    style: TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
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
                    style: TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
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
                      style: TextStyle(fontSize: 16, color: Color(0xff7C7D85)),
                    ),
                    Text(
                      '₹ 3,818.00',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                      side:
                          const BorderSide(width: 2, color: Color(0xffF30000))),
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
      ),
    );
  }
}

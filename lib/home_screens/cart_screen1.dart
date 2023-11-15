import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/orderscreens/confirmation_screen.dart';
import 'package:ezye/paymentScreens/coupan_screen.dart';
import 'package:ezye/paymentScreens/order_confirm_screen.dart';
import 'package:ezye/profilescreens/select_address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoggedIn = false;
  bool cashOndelivery = false;
  bool phonePe = false;
  bool isChecked = false;
  bool ezyeCoin = false;
  List<bool> checkboxValues = List.generate(3, (index) => false);
  int cartCount = 3;
  int counter = 0;
  int count = 1;
  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    checkLoginStatus(); // Call the function to fetch carousel data
  }

  void checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    int activeCheckboxes = checkboxValues.where((value) => value).length;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        height: 90,
        child: Column(
          children: [
            if (isLoggedIn == true)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: const Color.fromARGB(255, 213, 255, 221),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/offer.svg'),
                        const Text(
                          ' Your Savings ',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff00CA14)),
                        ),
                        const Text(
                          '₹ 9,076',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff00CA14)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff7C7D85)),
                            ),
                            Text(
                              '₹ 3,818.00',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor: Colors.black,
                                minimumSize: const Size(240, 46)),
                            onPressed: confirmOrder,
                            child: const Text(
                              'Checkout',
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
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: buttonColor),
        title: const Text('Cart', style: apptitle),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1,
              color: const Color(0xffE8E9EE),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLoggedIn == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: width / 1.5),
                    SvgPicture.asset('assets/svg/cloud.svg'),
                    const SizedBox(height: 20),
                    const Text(
                      'To access your account, please log in or create a new account.',
                      style: TextStyle(fontSize: 14, color: Color(0xff7C7D85)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            minimumSize: const Size(208, 56)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ))
                  ],
                ),
              ),
            if (isLoggedIn == true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              activeCheckboxes.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '/${cartCount}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Selected Items',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const Text(
                          '₹ 3,918',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: cartCount,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40, right: 10, top: 10, bottom: 5),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
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
                                            height: 100,
                                            width: 80,
                                            child: Image.asset(
                                              'assets/png/cloth.png',
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.7,
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
                                          Container(
                                            width: 50,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'XL',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(width: 5),
                                                SvgPicture.asset(
                                                    'assets/svg/arrowdown.svg')
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      border: Border.all(
                                                          width: 0.1,
                                                          color: Colors
                                                              .grey.shade200),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              decrementCounter();
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/svg/minus.svg',
                                                              height: 30,
                                                            )),
                                                        Text(
                                                          count.toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              incrementCounter();
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/svg/add.svg',
                                                              height: 30,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10,
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      const Text(
                                                        '₹2,000',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(width: 2),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          const Text(
                                                            '₹ 2,199',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xffBDC1CA),
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: const Color(
                                                                    0xff00CA14)),
                                                            child: const Text(
                                                              '10% Off',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 6,
                                left: 5,
                                child: Checkbox.adaptive(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  activeColor: Colors.black,
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                      width: 1, color: Colors.black),
                                  value: checkboxValues[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      checkboxValues[index] = value!;

                                      print(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Coupons',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1.5, color: const Color(0xffE8E9EE))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/coupan.svg'),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: devider,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CoupanPage()));
                            },
                            child: const Text(
                              'VIEW COUPONS',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Delivery Location',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectAddress()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1.5, color: Colors.black)),
                            child: const Text(
                              'CHANGE',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      '392, 1st Floor, Jnana Marga, 1st Stage, Siddhartha Layout, Mysuru, Karnataka 570011',
                      style: TextStyle(color: Color(0xff7C7D85)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text('Payment Method',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 30,
                              child: Checkbox.adaptive(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  activeColor: Colors.black,
                                  checkColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  value: cashOndelivery,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      cashOndelivery = value!;
                                      phonePe = false;
                                    });
                                  }),
                            ),
                            const Text(
                              'Cash on Delivery',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(width: 5),
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 30,
                              child: Checkbox.adaptive(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  activeColor: Colors.black,
                                  checkColor: Colors.white,
                                  value: phonePe,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      phonePe = value!;
                                      cashOndelivery = false;
                                    });
                                  }),
                            ),
                            const Text(
                              'Phonepe',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Stack(children: [
                      Image.asset('assets/png/Ezyecoinbar.png'),
                      Positioned(
                          top: 5,
                          bottom: 5,
                          left: 80,
                          right: 20,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 24,
                                width: 35,
                                child: Checkbox.adaptive(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    focusColor: Colors.white,
                                    activeColor: const Color(0xffF0D7A7),
                                    checkColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    side: const BorderSide(color: Colors.white),
                                    value: ezyeCoin,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        ezyeCoin = value!;
                                      });
                                    }),
                              ),
                              const Expanded(
                                child: Text(
                                  'Use EZYE coins to purchase user order. You save ₹100',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          )),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text('Billing Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                  ),
                  const Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
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
                  ),
                  const Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
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
                  ),
                  const Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
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
                  ),
                  if (ezyeCoin == true)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'EZYE Coins',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff00CA14)),
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
                    ),
                  const Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
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
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Row(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: const Color(0xffE8E9EE)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff7C7D85)),
                          ),
                          Text(
                            '₹ 3,818.00',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  void confirmOrder() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        isScrollControlled: true,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return BottomSheet(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            onClosing: () {},
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: ((context, setState) => Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.17,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.arrow_back)),
                                      const Text(
                                        'Confirm Order',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const Text('   ')
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.46,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 8),
                                          color: const Color(0xffE8E9EE),
                                          child: const Row(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Products',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff7C7D85),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                '(2)',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff7C7D85),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: SizedBox(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                primary: false,
                                                itemCount: cartCount,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              height: 80,
                                                              width: 60,
                                                              child:
                                                                  Image.asset(
                                                                'assets/png/cloth.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.5,
                                                              child: const Text(
                                                                'Men Blue Washed Denim Jacket men Blue',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            const Text(
                                                              'XL',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xffBDC1CA)),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const Column(
                                                                  children: [
                                                                    Text(
                                                                      '₹ 2,199',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Color(
                                                                              0xffBDC1CA),
                                                                          decoration:
                                                                              TextDecoration.lineThrough),
                                                                    ),
                                                                    Text(
                                                                      '₹2,000',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 2),
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          3),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: const Color(
                                                                          0xff00CA14)),
                                                                  child:
                                                                      const Text(
                                                                    '10% Off',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white),
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
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Text('Payment Method',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 24,
                                                    width: 30,
                                                    child: Checkbox.adaptive(
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        activeColor:
                                                            Colors.black,
                                                        checkColor:
                                                            Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                        value: cashOndelivery,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            cashOndelivery =
                                                                value!;
                                                            phonePe = false;
                                                          });
                                                        }),
                                                  ),
                                                  const Text(
                                                    'Cash on Delivery',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(width: 5),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 24,
                                                    width: 30,
                                                    child: Checkbox.adaptive(
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        activeColor:
                                                            Colors.black,
                                                        checkColor:
                                                            Colors.white,
                                                        value: phonePe,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7)),
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            phonePe = value!;
                                                            cashOndelivery =
                                                                false;
                                                          });
                                                        }),
                                                  ),
                                                  const Text(
                                                    'Phonepe',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Text('Billing Details',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total MRP',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff7C7D85)),
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
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Discount',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff00CA14)),
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
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Coupon Discount',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff7C7D85)),
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
                                        ),
                                        if (ezyeCoin == true)
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'EZYE Coins',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff00CA14)),
                                                ),
                                                Text(
                                                  '- ₹ 100.00',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff00CA14)),
                                                )
                                              ],
                                            ),
                                          ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Delivery Charges',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff7C7D85)),
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
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Tax',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff7C7D85)),
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: const Color(0xffE8E9EE)
                                                    .withOpacity(0.3)),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total Amount',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff7C7D85)),
                                                ),
                                                Text(
                                                  '₹ 3,818.00',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total Amount',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff7C7D85)),
                                          ),
                                          Text(
                                            '₹ 3,818.00',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              backgroundColor: Colors.black,
                                              minimumSize: const Size(240, 46)),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OrderConfirmScreen()));
                                          },
                                          child: const Text(
                                            'Confirm Order',
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
                          ),
                        ),
                      )));
            },
          );
        });
  }
}

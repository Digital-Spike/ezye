import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/constants/string_util.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/model/address.dart';
import 'package:ezye/model/cart_item.dart';
import 'package:ezye/model/coupon.dart';
import 'package:ezye/paymentScreens/coupon_screen.dart';
import 'package:ezye/paymentScreens/order_confirm_screen.dart';
import 'package:ezye/profilescreens/select_address.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoggedIn = false;
  bool cashOnDelivery = true;
  bool phonePe = false;
  bool isChecked = false;
  bool isEzyeCoinApplies = false;
  bool isCouponApplies = false;
  Coupon? selectedCoupon;
  double totalAmountWithDiscount = 0;

  Future<bool>? getCartFuture;
  List<CartItem> cartItems = [];
  List<Coupon> couponList = [];
  Address? selectedAddress;
  double itemTotalAmount = 0.0;
  double discount = 0.0;
  double deliveryCost = 49.0;
  double ezyeCoin = 0.0;
  double couponDiscountAmount = 0;
  double orderTotal = 0;

  TextEditingController couponController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCartFuture = getCartItems();
    checkLoginStatus();
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
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: FutureBuilder<bool>(
        future: getCartFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (cartItems.isEmpty) {
              return const Center(child: Text('Cart is empty!'));
            }

            List<bool> checkboxValues =
                List.generate(cartItems.length, (index) => true);

            int activeCheckboxes =
                checkboxValues.where((value) => value).length;
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomAppBar(
                padding: EdgeInsets.zero,
                elevation: 0,
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
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff00CA14)),
                                ),
                                Text(
                                  '₹ ${(couponDiscountAmount + ezyeCoin).toString()}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff00CA14)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Total Amount',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff7C7D85)),
                                    ),
                                    Text(
                                      '₹ $totalAmountWithDiscount',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          backgroundColor: Colors.black,
                                          minimumSize:
                                              const Size(double.infinity, 40)),
                                      onPressed: () {
                                        confirmOrder();
                                      },
                                      child: const Text(
                                        'Checkout',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )),
                                )
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
                    (!isLoggedIn)
                        ? Padding(
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
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff7C7D85)),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        minimumSize: const Size(208, 56)),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
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
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                color: Colors.black,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          activeCheckboxes.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '/${cartItems.length}',
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
                                    Text(
                                      '₹ $itemTotalAmount',
                                      style: const TextStyle(
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
                                    itemCount: cartItems.length,
                                    itemBuilder: (context, index) {
                                      CartItem cartItem = cartItems[index];
                                      return Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 40,
                                                right: 10,
                                                top: 10,
                                                bottom: 5),
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      height: 100,
                                                      width: 80,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            '${ApiService.uploads}${cartItem.productId}01.jpg',
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white30,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: Image.asset(
                                                            'assets/png/cloth.png',
                                                            height: 110,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        imageBuilder:
                                                            (context, image) =>
                                                                Image(
                                                          image: image,
                                                          height: 400,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
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
                                                            1.7,
                                                        child: Text(
                                                          '${cartItem.name}',
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        width: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${cartItem.size}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            SvgPicture.asset(
                                                                'assets/svg/arrowdown.svg')
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                width: 90,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              7),
                                                                  border: Border.all(
                                                                      width:
                                                                          0.1,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          if (int.parse(cartItem.quantity ?? '1') ==
                                                                              1) {
                                                                            showDeleteWarning(cartItem);
                                                                            return;
                                                                          }
                                                                          await updateQuantity(
                                                                              cartItem: cartItem,
                                                                              isIncrement: false);
                                                                          setState(
                                                                              () {
                                                                            getCartFuture =
                                                                                getCartItems();
                                                                          });
                                                                        },
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          'assets/svg/minus.svg',
                                                                          height:
                                                                              30,
                                                                        )),
                                                                    Text(
                                                                      '${cartItem.quantity}',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          await updateQuantity(
                                                                              cartItem: cartItem,
                                                                              isIncrement: true);
                                                                          setState(
                                                                              () {
                                                                            getCartFuture =
                                                                                getCartItems();
                                                                          });
                                                                        },
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          'assets/svg/add.svg',
                                                                          height:
                                                                              30,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    '₹${(double.parse(cartItem.mrp ?? '1') * double.parse(cartItem.quantity ?? '1'))}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  ),
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
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              activeColor: Colors.black,
                                              checkColor: Colors.white,
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              value: checkboxValues[index],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  checkboxValues[index] =
                                                      value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              const SizedBox(height: 5),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'COUPONS',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1.5,
                                          color: const Color(0xffE8E9EE))),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/svg/coupan.svg'),
                                              const SizedBox(width: 8),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.5,
                                                child: TextFormField(
                                                  controller: couponController,
                                                  enabled: false,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Enter coupon code',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xff7C7D85))),
                                                ),
                                              )
                                            ],
                                          ),
                                          isCouponApplies
                                              ? ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      backgroundColor:
                                                          Colors.green,
                                                      minimumSize:
                                                          const Size(130, 34)),
                                                  onPressed: () {
                                                    setState(() {
                                                      isCouponApplies =
                                                          !isCouponApplies;
                                                      updateAmount();
                                                    });
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.check_circle,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        'APPLIED',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      backgroundColor:
                                                          Colors.black,
                                                      minimumSize:
                                                          const Size(130, 34)),
                                                  onPressed: () {
                                                    setState(() {
                                                      isCouponApplies =
                                                          !isCouponApplies;
                                                      updateAmount();
                                                    });
                                                  },
                                                  child: const Text(
                                                    'APPLY COUPON',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: devider,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          selectedCoupon = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CouponPage()));
                                          couponController.text =
                                              selectedCoupon?.code ?? '';
                                          updateAmount();
                                          setState(() {});
                                        },
                                        child: const Text(
                                          'VIEW COUPONS',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Delivery Location',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        selectedAddress = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SelectAddress()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black)),
                                        child: const Text(
                                          'CHANGE',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: (selectedAddress?.line1 ?? "").isEmpty ||
                                        (selectedAddress?.line2 ?? "")
                                            .isEmpty ||
                                        (selectedAddress?.city ?? "").isEmpty ||
                                        (selectedAddress?.pinCode ?? "").isEmpty
                                    ? const Text(
                                        "Please add address.",
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : Text(
                                        '${selectedAddress?.line1 ?? ''}, ${selectedAddress?.line2 ?? ''}, ${selectedAddress?.city ?? ''}, ${selectedAddress?.pinCode ?? ''}.',
                                        style: const TextStyle(
                                            color: Color(0xff7C7D85)),
                                      ),
                              ),
                              const SizedBox(height: 5),
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
                                              activeColor: Colors.black,
                                              checkColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                              value: cashOnDelivery,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  cashOnDelivery = value!;
                                                  // phonePe = false;
                                                });
                                              }),
                                        ),
                                        const Text(
                                          'Cash on Delivery',
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: showEzyeCoins(),
                                child: Padding(
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
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  focusColor: Colors.white,
                                                  activeColor:
                                                      const Color(0xffF0D7A7),
                                                  checkColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  side: const BorderSide(
                                                      color: Colors.white),
                                                  value: isEzyeCoinApplies,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      isEzyeCoinApplies =
                                                          value!;
                                                      updateAmount();
                                                    });
                                                  }),
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Use EZYE coins to purchase user order. You save ₹ ${Provider.of<SessionObject>(context, listen: false).user.walletBalance}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        )),
                                  ]),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total MRP',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff7C7D85)),
                                    ),
                                    Text(
                                      '₹ $itemTotalAmount',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: isCouponApplies,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Coupon Discount',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff00CA14)),
                                      ),
                                      Text(
                                        '₹ $couponDiscountAmount',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff00CA14)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (isEzyeCoinApplies == true)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'EZYE Coins',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff00CA14)),
                                      ),
                                      Text(
                                        '₹ $ezyeCoin',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff00CA14)),
                                      )
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Delivery Charges',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff7C7D85)),
                                    ),
                                    Text(
                                      '₹ $deliveryCost',
                                      style: const TextStyle(
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Amount',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff7C7D85)),
                                      ),
                                      Text(
                                        '₹ $totalAmountWithDiscount',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
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

          if (snapshot.hasError || snapshot.data == false) {
            return const Text("Something went wrong. Please try again later");
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> confirmOrder() async {
    if ((selectedAddress?.line1 ?? "").isEmpty ||
        (selectedAddress?.line2 ?? "").isEmpty ||
        (selectedAddress?.city ?? "").isEmpty ||
        (selectedAddress?.pinCode ?? "").isEmpty) {
      selectedAddress = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SelectAddress()));
      setState(() {});
      return;
    }
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
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Products',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff7C7D85),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                '( ${cartItems.length} )',
                                                style: const TextStyle(
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
                                                itemCount: cartItems.length,
                                                itemBuilder: (context, index) {
                                                  CartItem cartItem =
                                                      cartItems[index];
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
                                                              child: Text(
                                                                '${cartItem.name}',
                                                                style: const TextStyle(
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
                                                            Text(
                                                              '${cartItem.size}',
                                                              style: const TextStyle(
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
                                                                Text(
                                                                  '₹${(double.parse(cartItem.mrp ?? '1') * double.parse(cartItem.quantity ?? '1'))}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),
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
                                                        value: cashOnDelivery,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            cashOnDelivery =
                                                                true;
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
                                              /*const SizedBox(width: 5),
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
                                                            cashOnDelivery =
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
                                              ),*/
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Total MRP',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff7C7D85)),
                                              ),
                                              Text(
                                                '₹ $itemTotalAmount',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Coupon Discount',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff00CA14)),
                                              ),
                                              Text(
                                                '₹ $couponDiscountAmount',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff00CA14)),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (isEzyeCoinApplies == true)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'EZYE Coins',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff00CA14)),
                                                ),
                                                Text(
                                                  '₹ $ezyeCoin',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff00CA14)),
                                                )
                                              ],
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Delivery Charges',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xff7C7D85)),
                                              ),
                                              Text(
                                                '₹ $deliveryCost',
                                                style: const TextStyle(
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Total Amount',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xff7C7D85)),
                                                ),
                                                Text(
                                                  '₹ $totalAmountWithDiscount',
                                                  style: const TextStyle(
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Total Amount',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff7C7D85)),
                                          ),
                                          Text(
                                            '₹ $totalAmountWithDiscount',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                backgroundColor: Colors.black,
                                                minimumSize:
                                                    const Size(240, 46)),
                                            onPressed: () async {
                                              showProcessingDialogue();
                                              await placeOrder();
                                              if (!mounted) {
                                                return;
                                              }
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const OrderConfirmScreen()),
                                                (route) => false,
                                              );
                                            },
                                            child: const Text(
                                              'Confirm Order',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            )),
                                      ),
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

  Future<bool> getCartItems() async {
    try {
      await getAddress();
      var productUrl = Uri.parse('${ApiService.url}getCartDetails.php');
      var response = await http.post(productUrl, body: {
        "cartId":
            Provider.of<SessionObject>(context, listen: false).user.cartId ?? ""
      });

      if (response.statusCode == 200) {
        cartItems =
            (json.decode((response.body).toString().replaceAll('connected', ''))
                    as List)
                .map((item) => CartItem.fromJson(item))
                .toList();
        Provider.of<SessionObject>(context, listen: false)
            .updateCartCount(count: cartItems.length.toString());
      }
      updateCartTotal();
      await getCoupon();
      return true;
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }

  showDeleteWarning(CartItem cartItem) {
    return showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Delete from cart?',
                  style: title,
                ),
                const SizedBox(height: 10),
                divider,
                const SizedBox(height: 10),
                Text(
                  'Are you sure you want to delete this item from cart?',
                  style: content1,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.grey[300],
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: subtitle1,
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: buttonColor,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () async {
                            await removeCartItem(cartItem);
                            Navigator.pop(context);
                            setState(() {
                              getCartFuture = getCartItems();
                            });
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> removeCartItem(CartItem cartItem) async {
    try {
      var removeFromWishlistUrl =
          Uri.parse('${ApiService.url}removeCartItem.php');
      var reqBody = {
        "userId":
            Provider.of<SessionObject>(context, listen: false).user.userId,
        "productId": cartItem.productId
      };

      var response = await http.post(removeFromWishlistUrl, body: reqBody);
      if (response.statusCode == 200) {
        return !jsonDecode(
            (response.body).toString().replaceAll('connected', ''))['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> updateQuantity(
      {required CartItem cartItem, required bool isIncrement}) async {
    try {
      int count = isIncrement ? 1 : -1;
      var removeFromWishlistUrl =
          Uri.parse('${ApiService.url}updateCartQuantity.php');
      var reqBody = {
        "quantity": (int.parse(cartItem.quantity ?? '1') + count).toString(),
        "cartId":
            Provider.of<SessionObject>(context, listen: false).user.cartId ??
                "",
        "productId": cartItem.productId
      };
      await http.post(removeFromWishlistUrl, body: reqBody);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getAddress() async {
    try {
      var url = Uri.parse('${ApiService.url}getUserAddress.php');
      var reqBody = {
        "userId": Provider.of<SessionObject>(context, listen: false).user.userId
      };

      var response = await http.post(url, body: reqBody);
      if (response.statusCode == 200 &&
          (json.decode(response.body) as List).isNotEmpty) {
        selectedAddress =
            (json.decode((response.body).toString().replaceAll('connected', ''))
                    as List)
                .map((item) => Address.fromJson(item))
                .toList()
                .first;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateCartTotal() {
    itemTotalAmount = 0;
    discount = 0;
    for (var cartItem in cartItems) {
      itemTotalAmount += double.parse(cartItem.mrp ?? "0") *
          double.parse(cartItem.quantity ?? "0");
      discount +=
          double.parse(cartItem.mrp ?? "0") - double.parse(cartItem.mrp ?? "0");
    }
  }

  getCartTotal() {
    return itemTotalAmount + deliveryCost;
  }

  Future<bool> placeOrder() async {
    try {
      var createOrderUrl = Uri.parse('${ApiService.url}createOrder.php');
      var reqBody = {
        "cartId":
            Provider.of<SessionObject>(context, listen: false).user.cartId ??
                "",
        "userId":
            Provider.of<SessionObject>(context, listen: false).user.userId,
        "orderId": StringUtil.getRandomString(8),
        "totalAmount": getCartTotal().toString(),
        "paymentMethod": 'cash',
        "address":
            '${selectedAddress?.line1}, ${selectedAddress?.line2}, ${selectedAddress?.city}, ${selectedAddress?.pinCode}.',
        "couponCode": selectedCoupon?.code ?? '',
        "finalAmount": totalAmountWithDiscount.toString(),
        "ezyeCoin": ezyeCoin.toString()
      };

      var response = await http.post(createOrderUrl, body: reqBody);
      if (response.statusCode == 200) {
        await UserService.updateUser(context: context);
        return !jsonDecode(
            (response.body).toString().replaceAll('connected', ''))['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
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
        selectedCoupon = couponList.first;
        couponController.text = selectedCoupon?.code ?? '';
        updateAmount();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  showProcessingDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Processing...',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  updateAmount() {
    if (isCouponApplies &&
        getCartTotal() >= double.parse(selectedCoupon?.minimumAmount ?? '0')) {
      isCouponApplies = true;
      couponDiscountAmount = double.parse(selectedCoupon?.amount ?? '0');
    }

    if (isCouponApplies &&
        getCartTotal() < double.parse(selectedCoupon?.minimumAmount ?? '0')) {
      isCouponApplies = false;
      couponDiscountAmount = 0;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select valid coupon."),
          backgroundColor: Colors.redAccent,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ),
      );
    }

    if (!isCouponApplies) {
      couponDiscountAmount = 0;
    }

    ezyeCoin = double.parse(isEzyeCoinApplies
        ? Provider.of<SessionObject>(context, listen: false)
                .user
                .walletBalance ??
            '0'
        : '0');
    totalAmountWithDiscount = getCartTotal() - ezyeCoin - couponDiscountAmount;
    orderTotal = getCartTotal() + ezyeCoin + couponDiscountAmount;
  }

  showEzyeCoins() {
    if ((Provider.of<SessionObject>(context, listen: false)
                    .user
                    .walletBalance ??
                '')
            .isNotEmpty &&
        double.parse(Provider.of<SessionObject>(context, listen: false)
                    .user
                    .walletBalance ??
                '0') >
            0) {
      return true;
    }
    return false;
  }
}

import 'dart:convert';

import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/dashed_line.dart';
import 'package:ezys/model/cart_item.dart';
import 'package:ezys/paymentScreens/checkout_screen.dart';
import 'package:ezys/paymentScreens/coupan_screen.dart';
import 'package:ezys/services/api_service.dart';
import 'package:ezys/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoggedIn = false;
  int counter = 0;
  final ScrollController _scrollController = ScrollController();
  bool showOriginalContainer = false;
  int count = 1;

  double itemTotalAmount = 0.0;
  double discount = 0.0;
  double deliveryCost = 49.0;

  List<CartItem> cartItems = [];
  Future<bool>? getCartFuture;

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

  void moveToTop(int index) {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('My Cart', style: apptitle),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: FutureBuilder<bool>(
        future: getCartFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            updateCartTotal();
            if (cartItems.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Image.asset('assets/Add to Cart.gif')),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            CartItem cartItem = cartItems[index];

                            return Slidable(
                              endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                        onPressed: ((context) async {
                                          await removeCartItem(cartItem);
                                          setState(() {
                                            getCartFuture = getCartItems();
                                          });
                                        }),
                                        icon: CupertinoIcons.delete,
                                        backgroundColor: Colors.red.shade300,
                                        label: 'Remove')
                                  ]),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/error.png'),
                                                fit: BoxFit.contain,
                                              )),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const Text("Title",
                                                  style: subtitle),
                                              const SizedBox(height: 5),
                                              Text(
                                                cartItem.name ?? '',
                                                style: content,
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Size ${cartItem.size}',
                                                style: content,
                                              ),
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    cartItem.sellingPrice ?? '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      border: Border.all(
                                                          width: 0.5,
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
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors
                                                                  .grey[300],
                                                            ),
                                                            child: const Icon(
                                                              CupertinoIcons
                                                                  .minus,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        Text(
                                                          cartItem.quantity ??
                                                              '',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        GestureDetector(
                                                          onTap: () {
                                                            incrementCounter();
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  buttonColor,
                                                            ),
                                                            child: const Icon(
                                                              CupertinoIcons
                                                                  .add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.grey.shade400)),
                                          child: const Text(
                                            'View Similar Products',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        Colors.grey.shade400)),
                                            child: const Text(
                                              'Save For Later',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              minimumSize: const Size(380, 50)),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: bgcolor,
                              elevation: 5,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: context,
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  height: 350,
                                  decoration: const BoxDecoration(
                                      color: bgcolor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                            //   child: SizedBox(
                                            //     height: 45,
                                            //     child: TextField(
                                            //       decoration: InputDecoration(
                                            //         isDense: true,
                                            //         hintText: 'Promo Code',
                                            //         suffixIcon: Padding(
                                            //           padding: const EdgeInsets.all(3.0),
                                            //           child: ElevatedButton(
                                            //             style: ElevatedButton.styleFrom(
                                            //               backgroundColor: buttonColor,
                                            //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),minimumSize: Size(80, 40)),
                                            //             onPressed: (){}, child: Text('Apply',style: TextStyle(fontWeight: FontWeight.bold),)),
                                            //         ),
                                            //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                                            //     ),
                                            //   ),
                                            // ),
                                            Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color:
                                                          Colors.grey.shade600),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          'WELCOME100',
                                                          style: title,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {},
                                                            child: const Text(
                                                              'Apply',
                                                              style: title1,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: DashLine(
                                                        color: Colors.grey),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const CoupanPage()));
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "View more Coupon's",
                                                          style: content2,
                                                        ),
                                                        Icon(
                                                          CupertinoIcons
                                                              .forward,
                                                          color:
                                                              Colors.grey[600],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Sub-Total',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600]),
                                                ),
                                                Text(
                                                  '₹$itemTotalAmount',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 15),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Delivery Fee',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600]),
                                                ),
                                                Text(
                                                  '₹$deliveryCost',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            /*const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Discount',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600]),
                                                ),
                                                const Text(
                                                  '- ₹59',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),*/
                                            const SizedBox(height: 10),
                                            const DashLine(
                                              color: Colors.grey,
                                            ),

                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[600]),
                                                ),
                                                Text(
                                                  '₹${getCartTotal()}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),

                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        buttonColor,
                                                    minimumSize:
                                                        const Size(400, 50),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30)))),
                                                onPressed: () {
                                                  if (isLoggedIn) {
                                                    // User is logged in, navigate to the payment page
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CheckOutPage(
                                                                  cartItems:
                                                                      cartItems,
                                                                  cartTotal:
                                                                      getCartTotal(),
                                                                )));
                                                  } else {
                                                    // User is not logged in, show the login dialog
                                                    _showLoginDialog();
                                                  }
                                                },
                                                child: const Text(
                                                  'Proceed to Checkout',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            }
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

  Future<bool> getCartItems() async {
    try {
      var productUrl = Uri.parse('${ApiService.url}/getCartDetails.php');
      var response =
          await http.post(productUrl, body: {"cartId": FirebaseUser.cartId});

      if (response.statusCode == 200) {
        cartItems = (json.decode(response.body) as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
      }
      return true;
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }

  void _showLoginDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:
              const Text('Login Required!', style: TextStyle(color: indicator)),
          content:
              const Text('You need to log in to continue with the Checkout.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Log In',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
        );
      },
    );
  }

  updateCartTotal() {
    for (var cartItem in cartItems) {
      itemTotalAmount += double.parse(cartItem.sellingPrice ?? "0") *
          double.parse(cartItem.quantity ?? "0");
      discount += double.parse(cartItem.sellingPrice ?? "0") -
          double.parse(cartItem.sellingPrice ?? "0");
    }
  }

  getCartTotal() {
    return itemTotalAmount + deliveryCost;
  }

  Future<bool> removeCartItem(CartItem cartItem) async {
    try {
      var removeFromWishlistUrl =
          Uri.parse('${ApiService.url}/removeCartItem.php');
      var reqBody = {
        "userId": FirebaseUser.user?.uid ?? '',
        "productId": cartItem.productId
      };

      var response = await http.post(removeFromWishlistUrl, body: reqBody);
      if (response.statusCode == 200) {
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
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
}

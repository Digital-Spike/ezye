import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/home_screens/home_screen.dart';
import 'package:ezye/model/address.dart';
import 'package:ezye/model/cart_item.dart';
import 'package:ezye/paymentScreens/payment_screen.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class CheckOutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double cartTotal;

  const CheckOutPage(
      {super.key, required this.cartItems, required this.cartTotal});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Future<void>? getCartFuture;
  bool isLoggedIn = false;
  String? canCall;
  List<Address> addressList = [];
  final _formKey = GlobalKey<FormState>();
  ShippingType shippingType = ShippingType.home;
  int addressIndex = 0;
  Address? selectedAddress;

  final TextEditingController house = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pincode = TextEditingController();

  @override
  void initState() {
    getCartFuture = getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Checkout', style: apptitle),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 100,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Text('₹${widget.cartTotal}',
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: const Size(150, 45)),
              onPressed: () {
                if (selectedAddress?.line1 == null) {
                  addNewAddress();
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentPage(
                              address: selectedAddress ?? Address(),
                              totalAmount: widget.cartTotal.toString(),
                            )));
              },
              child: const Row(
                children: [
                  Text(
                    'Continue to Payment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<void>(
        future: getCartFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: selectedAddress?.line1 != null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Shipping Address', style: title),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.placemark),
                            const SizedBox(
                              width: 5,
                            ),
                            Text((selectedAddress?.type ?? "").toUpperCase(),
                                style: subtitle),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                '${selectedAddress?.line1}, ${selectedAddress?.line2}, ${selectedAddress?.city}, ${selectedAddress?.pinCode}.',
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 14.5),
                              )),
                              const SizedBox(
                                width: 40,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _address();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 0.5,
                                            color: Colors.grey.shade400)),
                                    child: const Text(
                                      'CHANGE',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Order List', style: title),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        CartItem cartItem = widget.cartItems[index];
                        return Slidable(
                          endActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: ((context) {}),
                                  icon: CupertinoIcons.delete,
                                  backgroundColor: Colors.red.shade300,
                                  label: 'Remove',
                                )
                              ]),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  // decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(12),
                                  //     image: const DecorationImage(
                                  //       image: AssetImage('assets/image1.jpeg'),
                                  //       fit: BoxFit.cover,
                                  //     )),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${ApiService.uploads}${cartItem.productId}01.jpg',
                                    placeholder: (context, url) =>
                                        const CircleAvatar(
                                      backgroundColor: Colors.white30,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Image.asset(
                                        'assets/ERROR1.png',
                                        height: 110,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    imageBuilder: (context, image) => Image(
                                      image: image,
                                      height: 400,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text('${cartItem.name}', style: subtitle),
                                      const SizedBox(height: 5),
                                      Text('Color: ${cartItem.color}',
                                          style: content),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text('Size: ${cartItem.size}',
                                              style: content),
                                          const SizedBox(width: 5),
                                          Container(
                                            height: 12,
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Qty : ${cartItem.quantity}',
                                            style: content,
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Price: ₹${cartItem.mrp}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.25, color: Colors.grey.shade400),
                        color: Colors.white),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add More Items',
                          style: subtitle,
                        ),
                        Icon(CupertinoIcons.add_circled)
                      ],
                    ),
                  ),
                )
              ],
            );
          }

          if (snapshot.hasError) {
            return const Text("Something went wrong. Please try again later");
          }

          return Center(
            child: Image.asset(
              'assets/animation.gif',
              height: 150,
              width: 250,
            ),
          );
        },
      ),
    );
  }

  void _address() {
    showModalBottomSheet(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Shipping Address',
                      style: title,
                    ),
                  ),
                  const SizedBox(height: 5),
                  devider,
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: addressList.length,
                      itemBuilder: ((context, index) {
                        Address address = addressList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              addressIndex = index;
                              selectedAddress = address;
                            });
                          },
                          child: ListTile(
                            leading: Radio<int>(
                              value: addressIndex,
                              groupValue: index,
                              onChanged: (value) {},
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.placemark,
                                      color: buttonColor,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      (address.type ?? '').toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '${address.line1}, ${address.line2}, ${address.city}, ${address.pinCode}.',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:
                              Divider(thickness: 0.5, color: Colors.grey[400]),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          minimumSize: const Size(double.infinity, 50)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        addNewAddress();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add New Shipping Address',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addNewAddress() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Shipping Address',
                        style: title,
                      ),
                    ),
                    const SizedBox(height: 5),
                    devider,
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio<ShippingType>(
                                value: ShippingType.home,
                                groupValue: shippingType,
                                onChanged: (ShippingType? value) {
                                  setState(() {
                                    shippingType = value!;
                                  });
                                },
                              ),
                              const Text('Home'),
                              Radio<ShippingType>(
                                value: ShippingType.work,
                                groupValue: shippingType,
                                onChanged: (ShippingType? value) {
                                  setState(() {
                                    shippingType = value!;
                                  });
                                },
                              ),
                              const Text('Work'),
                              Radio<ShippingType>(
                                value: ShippingType.others,
                                groupValue: shippingType,
                                onChanged: (ShippingType? value) {
                                  setState(() {
                                    shippingType = value!;
                                  });
                                },
                              ),
                              const Text('Others'),
                            ],
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: house,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter House/Flat/Door No';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'House/Flat/Door No',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _street,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Landmark/Street/Nearby';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Landmark/Street/Nearby',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _city,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter City name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Your City',
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: _pincode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Pincode';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Pincode',
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                minimumSize: const Size(380, 50)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                bool response = await addAddress();
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response
                                        ? "Address added successfully"
                                        : "Something went wrong. please try again later.."),
                                    backgroundColor: response
                                        ? Colors.green
                                        : Colors.redAccent,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(5),
                                  ),
                                );
                              }
                            },
                            child: const Text('Save',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }).whenComplete(() {
      setState(() {
        getCartFuture = getCart();
      });
    });
  }

  Future<void> getCart() async {
    var removeFromWishlistUrl =
        Uri.parse('${ApiService.url}getUserAddress.php');
    var reqBody = {"userId": FirebaseUser.user?.uid ?? ''};

    var response = await http.post(removeFromWishlistUrl, body: reqBody);
    if (response.statusCode == 200) {
      addressList =
          (json.decode((response.body).toString().replaceAll('connected', ''))
                  as List)
              .map((item) => Address.fromJson(item))
              .toList();
      selectedAddress = addressList.first;
    }
  }

  Future<bool> addAddress() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.url}addAddress.php'),
        body: {
          'userId': FirebaseUser.user?.uid,
          'line1': house.text,
          'line2': _street.text,
          'city': _city.text,
          'pincode': _pincode.text,
          'type': shippingType.name,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

enum ShippingType { home, work, others }

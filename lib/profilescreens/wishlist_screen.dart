import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/Auth_screen/login_screen.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/home_screens/product_screen.dart';
import 'package:ezye/services/api_service.dart';
import 'package:ezye/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  bool isLoggedIn = false;
  Future<void>? listItems;
  List<Product> products = [];

  void checkLoginStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    checkLoginStatus();
    listItems = getItems();
    super.initState();
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Wishlist',
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
      body: Column(
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
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff7C7D85)),
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
                )
              : FutureBuilder<void>(
                  future: listItems,

                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (products.isEmpty) {
                        return Container(
                          margin: EdgeInsets.only(top: 300),

                          child: Center(child: Text("No items found!")));
                      }

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: GridView.builder(
                              itemCount: products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 1.92,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2),
                              itemBuilder: ((context, index) {
                                Product product = products[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                  productId:
                                                      product.productId ?? "",
                                                )));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${ApiService.uploads}${product.productId}01.jpg',
                                          placeholder: (context, url) =>
                                              const CircleAvatar(
                                            backgroundColor: Colors.white30,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Image.asset(
                                              'assets/png/cloth.png',
                                              fit: BoxFit.contain,
                                              height: 220,
                                            ),
                                          ),
                                          imageBuilder: (context, image) =>
                                              Image(
                                            image: image,
                                            height: 220,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.black),
                                            child: const Text(
                                              'EZYE',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 5),
                                            child: SvgPicture.asset(
                                                'assets/svg/redheart.svg'),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              '${product.name}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              '₹${product.sellingPrice}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Text(
                          "Something went wrong. Please try again later");
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })
        ],
      ),
    );
  }

  Future<void> getItems() async {
    try {
      var response = await http.post(
          Uri.parse('${ApiService.url}getUserWishlist.php'),
          body: {"userId": FirebaseUser.user?.uid ?? ''});
      products =
          (json.decode((response.body).toString().replaceAll('connected', ''))
                  as List)
              .map((item) => Product.fromJson(item))
              .toList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

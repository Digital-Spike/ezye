import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/home_screens/cart_screen.dart';
import 'package:ezye/home_screens/product_screen.dart';
import 'package:ezye/model/product.dart';
import 'package:ezye/profilescreens/wishlist_screen1.dart';
import 'package:ezye/providers/session_object.dart';
import 'package:ezye/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLiked = false;
  Future<bool>? listItems;
  List<Product> products = [];
  User? user = FirebaseAuth.instance.currentUser;
  List<Product> bookmarkList = [];

  @override
  void initState() {
    super.initState();
    listItems = getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                height: 46,
                width: 46,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffE8E9EE).withOpacity(0.3)),
                child: SvgPicture.asset(
                  'assets/svg/search.svg',
                ),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WishListScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 46,
                  width: 46,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffE8E9EE).withOpacity(0.3)),
                  child: SvgPicture.asset(
                    'assets/svg/heart.svg',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 46,
                  width: 46,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffE8E9EE).withOpacity(0.3)),
                  child: SvgPicture.asset(
                    'assets/svg/cart.svg',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: FutureBuilder<bool>(
            future: listItems,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.category}'s Collections",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text('${products.length} Products')
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/svg/filter.svg'),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Filter',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: GridView.builder(
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1 / 1.92,
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemBuilder: ((context, index) {
                              Product product = products[index];
                              products[index].isSaved = isSaved(product);
                              print(products[index].isSaved);
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
                                        imageBuilder: (context, image) => Image(
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
                                        GestureDetector(
                                            onTap: () async {
                                              isLiked = isSaved(product);
                                              !isSaved(product)
                                                  ? await addToWishlist(product)
                                                  : await removeFromWishlist(
                                                      product);
                                              setState(() {
                                                products[index].isSaved =
                                                    !isLiked;
                                              });
                                            },
                                            child: SvgPicture.asset(
                                              products[index].isSaved
                                                  ? 'assets/svg/redheart.svg'
                                                  : 'assets/svg/greyheart.svg',
                                            ))
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name ?? "",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          '₹${product.mrp ?? ""}',
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Color(0xff7C7D85),
                                              fontSize: 14),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '₹${product.sellingPrice ?? ""}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 5),
                                        Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
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
                              );
                            })),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return const Text(
                    "Something went wrong. Please try again later");
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }

  Future<bool> getItems() async {
    try {
      var productsUrl = Uri.parse('${ApiService.url}/globalSearch.php');
      var productsResponse =
          await http.post(productsUrl, body: {'key': widget.category});

      products = (json.decode(productsResponse.body) as List)
          .map((item) => Product.fromJson(item))
          .toList();

      if (SessionObject.user.userId != null) {
        await getWishList();
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return true;
  }

  Future<bool> addToWishlist(Product product) async {
    try {
      var addToWishlistUrl = Uri.parse('${ApiService.url}/wishList.php');
      var reqBody = {
        "userId": user?.uid ?? '',
        "productId": product.productId,
        "name": product.name,
        "category": product.category,
        "subCategory": product.subCategory,
        "MRP": product.mrp,
        "sellingPrice": product.sellingPrice,
        "description": product.description,
      };

      var response = await http.post(addToWishlistUrl, body: reqBody);
      if (response.statusCode == 200) {
        await getWishList();
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> getWishList() async {
    String bookmarkUrl = "${ApiService.url}getUserWishlist.php";
    var bookmarkResponse =
        await http.post(Uri.parse(bookmarkUrl), body: {"userId": user?.uid});
    bookmarkList = (json.decode(bookmarkResponse.body) as List)
        .map((item) => Product.fromJson(item))
        .toList();
  }

  bool isSaved(Product product) {
    List<Product> list = bookmarkList
        .where((element) => element.productId == product.productId)
        .toList();
    return list.isNotEmpty;
  }

  Future<bool> removeFromWishlist(Product product) async {
    try {
      var removeFromWishlistUrl =
          Uri.parse('${ApiService.url}/removeWishlist.php');
      var reqBody = {"userId": user?.uid ?? '', "productId": product.productId};

      var response = await http.post(removeFromWishlistUrl, body: reqBody);
      if (response.statusCode == 200) {
        await getWishList();
        return !jsonDecode(response.body)['error'];
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

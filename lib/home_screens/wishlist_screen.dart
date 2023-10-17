import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/multiselectchoicechip_widget.dart';
import 'package:ezys/custom_widgets/persistentheader.dart';
import 'package:ezys/home_screens/main_screen.dart';
import 'package:ezys/home_screens/product_detail_screen.dart';
import 'package:ezys/model/product.dart';
import 'package:ezys/services/api_service.dart';
import 'package:ezys/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool isLiked = false;
  int counter = 0;
  List<String> subcategory = [];
  Future<void>? listItems;
  List<Product> products = [];

  @override
  void initState() {
    listItems = getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        mainAppBar: AppBar(
          title: const Text('My Wishlist', style: apptitle),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        mainChild: FutureBuilder<void>(
            future: listItems,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (products.isEmpty) {
                  return const Center(child: Text("No items found!"));
                }

                return CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: PersistentHeader(
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                              width: double.infinity,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return MultiSelectChoiceChips(
                                      options: const [
                                        'All',
                                        'Latest',
                                        'Hot Deals',
                                        'Men',
                                        'Women',
                                        'Boys',
                                        'Girls',
                                      ],
                                      onSelectionChanged: (selectedOptions) {
                                        setState(() {
                                          subcategory = selectedOptions;
                                        });
                                      },
                                    );
                                  })),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(10.0),
                      sliver: SliverGrid.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                            mainAxisExtent: 241,
                          ),
                          itemBuilder: ((context, index) {
                            Product product = products[index];

                            return Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.25, color: Colors.grey),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                // image: DecorationImage(image: AssetImage('assets/image.jpeg'))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetail(
                                                        itemPrice:
                                                            product.sellingPrice ??
                                                                '',
                                                        productId:
                                                            product.productId ??
                                                                '')));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    '${ApiService.uploads}${product.productId}01.jpg',
                                                placeholder: (context, url) =>
                                                    const CircleAvatar(
                                                  backgroundColor:
                                                      Colors.white30,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Image.asset(
                                                    'assets/ERROR1.png',
                                                    height: 150,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                imageBuilder:
                                                    (context, image) => Image(
                                                  image: image,
                                                  height: 150,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  gradient:
                                                      const LinearGradient(
                                                    // stops: [0,5],
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Colors.black26,
                                                      Colors.transparent
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text('${product.name}',
                                      style: TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 5),
                                  Text('${product.description}'),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${product.mrp}',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.green[800],
                                            decorationColor: Colors.green[800],
                                            decorationThickness: 3),
                                      ),
                                      const SizedBox(width: 5),
                                      Text('- ₹${product.sellingPrice}'),
                                    ],
                                  )
                                ],
                              ),
                            );
                          })),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                return const Text(
                    "Something went wrong. Please try again later");
              }

              return Center(
                child: Image.asset(
                  'assets/animation.gif',
                  height: 150,
                  width: 250,
                ),
              );
            }));
  }

  Future<void> getItems() async {
    try {
      var response = await http.post(
          Uri.parse('${ApiService.url}/getUserWishlist.php'),
          body: {"userId": FirebaseUser.user?.uid ?? ''});
      products = (json.decode(response.body) as List)
          .map((item) => Product.fromJson(item))
          .toList();

      print(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

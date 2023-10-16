import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezys/Auth_screen/login_screen.dart';
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/multiselectchoicechip_widget.dart';
import 'package:ezys/custom_widgets/persistentheader.dart';
import 'package:ezys/home_screens/cart_screen.dart';
import 'package:ezys/home_screens/category_screen.dart';
import 'package:ezys/home_screens/main_screen.dart';
import 'package:ezys/home_screens/product_detail_screen.dart';
import 'package:ezys/home_screens/search_screen.dart';
import 'package:ezys/home_screens/wishlist_screen.dart';
import 'package:ezys/model/category.dart';
import 'package:ezys/model/product.dart';
import 'package:ezys/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class CarouselItem {
  final String imageUrl;

  CarouselItem({
    required this.imageUrl,
  });

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      imageUrl: json['imageUrl'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = false;
  List<CarouselItem> carouselItems = [];

  List<Category> categories = [];
  List<Product> products = [];
  List<String> subcategory = [];
  List<Product> bookmarkList = [];
  bool isLiked = false;
  User? user = FirebaseAuth.instance.currentUser;

  final List<String> imgList = [
    'assets/ezye2.png',
  ];
  List<String> imageUrls = [
    'assets/t-shirt.png',
    'assets/pants.png',
    'assets/dress.png',
    'assets/shirt.png',
  ];
  final List<String> imageNames = [
    'Men',
    'Kid',
    'Women',
    'Junior',

    // Add more image names corresponding to the URLs.
  ];
  final List<String> subCategories = [
    'All',
    'Latest',
    'Hot Deals',
    'Men',
    'Women',
    'Boys',
    'Girls',
  ];

  Future<bool>? listItems;

  @override
  void initState() {
    super.initState();
    listItems = getItems();
    checkLoginStatus(); // Call the function to fetch carousel data
  }

  void checkLoginStatus() {
    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: bgcolor,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: Colors.grey.shade800)),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/Search.svg',
                          height: 20, width: 20, color: Colors.grey[800]),
                      const SizedBox(width: 10),
                      Text(
                        'Search Your Favorite...',
                        style: content1,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(minimumSize: const Size(25, 25)),
              onPressed: () {
                if (isLoggedIn) {
                  // User is logged in, navigate to the payment page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WishList()));
                } else {
                  // User is not logged in, show the login dialog
                  _showLoginDialog1();
                }
              },
              child: Image.asset(
                'assets/icons/heart.png',
                height: 25,
                width: 25,
              )),
          TextButton(
              style: TextButton.styleFrom(minimumSize: const Size(25, 25)),
              onPressed: () {
                if (isLoggedIn) {
                  // User is logged in, navigate to the payment page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                } else {
                  // User is not logged in, show the login dialog
                  _showLoginDialog();
                }
              },
              child: Image.asset(
                'assets/icons/shoppingbag.png',
                height: 25,
                width: 25,
              ))
        ],
      ),
      mainChild: FutureBuilder<bool>(
          future: listItems,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: bgcolor,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    expandedHeight: 337,
                    pinned: false,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      collapseMode: CollapseMode.parallax,
                      title: Container(),
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            items: imgList.map((item) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                  ),
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1.09,
                              enlargeCenterPage: true,
                              autoPlay: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Category', style: subtitle),
                                GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'See all',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: indicator),
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: SizedBox(
                              height: 80, // Adjust the height as needed
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22, vertical: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategoryPage(
                                                          category:
                                                              category.name ??
                                                                  '',
                                                        )));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            // height: 50,
                                            // width: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.25,
                                                  color: Colors.grey),
                                              color: Colors.grey[350],
                                              shape: BoxShape.circle,
                                              // image: DecorationImage(
                                              //   image: Image.asset(imageUrls[index]),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: '',
                                              placeholder: (context, url) =>
                                                  const CircleAvatar(
                                                backgroundColor: Colors.white30,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Padding(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                child: Image.asset(
                                                  'assets/ERROR1.png',
                                                  height: 30,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              imageBuilder: (context, image) =>
                                                  Image(
                                                image: image,
                                                height: 30,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        // Space between image and name
                                        Text(category.name ?? ''),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                        products[index].isSaved = isSaved(product);
                        return Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.25, color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            // image: DecorationImage(image: AssetImage('assets/image.jpeg'))
                          ),
                          child: Stack(
                            children: [
                              Column(
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
                                                                "0",
                                                        productId:
                                                            product.productId ??
                                                                '')));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Colors.black.withOpacity(0.2),
                                                Colors.transparent
                                              ],
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: '',
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(product.name ?? "",
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 5),
                                  Expanded(
                                      child: Text(
                                    product.fullDescription ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        '₹${product.mrp ?? ""}',
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
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            isLiked = isSaved(product);
                                            isLiked
                                                ? await addToWishlist(product)
                                                : await removeFromWishlist(
                                                    product);
                                            setState(() {
                                              products[index].isSaved =
                                                  !isLiked;
                                            });
                                          },
                                          child: Image.asset(
                                            products[index].isSaved
                                                ? 'assets/icons/White heart.png'
                                                : 'assets/icons/Comp 232.gif',
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
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
          }),
    );
  }

  Future<bool> getItems() async {
    try {
      var categoryUrl = Uri.parse('${ApiService.url}/getAllCategories.php');
      var categoryResponse = await http.post(categoryUrl);

      var productsUrl = Uri.parse('${ApiService.url}/getAllProducts.php');
      var productsResponse = await http.post(productsUrl);

      await getWishList();

      categories = (json.decode(categoryResponse.body) as List)
          .map((item) => Category.fromJson(item))
          .toList();

      products = (json.decode(productsResponse.body) as List)
          .map((item) => Product.fromJson(item))
          .toList();

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return true;
  }

  bool isSaved(Product product) {
    List<Product> list = bookmarkList
        .where((element) => element.productId == product.productId)
        .toList();
    return list.isEmpty;
  }

  Future<void> getWishList() async {
    String bookmarkUrl = "${ApiService.url}getUserWishlist.php";
    var bookmarkResponse =
        await http.post(Uri.parse(bookmarkUrl), body: {"userId": user?.uid});
    bookmarkList = (json.decode(bookmarkResponse.body) as List)
        .map((item) => Product.fromJson(item))
        .toList();
  }

  void _showLoginDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title:
              const Text('Login Required!', style: TextStyle(color: indicator)),
          content: const Text('You have to log in to continue to Check Cart.'),
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

  void _showLoginDialog1() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Login Required!',
            style: TextStyle(color: indicator),
          ),
          content: const Text('You need to log in to Check Your Wishlist.'),
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
}

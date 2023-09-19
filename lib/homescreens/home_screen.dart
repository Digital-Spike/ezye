import 'dart:convert';
import 'package:ezys/homescreens/search_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/multiselectchoicechip_widget.dart';
import 'package:ezys/custom_widgets/persistentheader.dart';
import 'package:ezys/homescreens/cart_screen.dart';
import 'package:ezys/homescreens/category_screen.dart';
import 'package:ezys/homescreens/main_screen.dart';
import 'package:ezys/homescreens/product_detail_screen.dart';
import 'package:ezys/homescreens/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  List<CarouselItem> carouselItems = [];

  List<String> subcategory = [];
  bool isLiked = false;
  final List<String> imgList = [
    'assets/ezye2.png',
  ];
  List<String> imageUrls = [
    'assets/t-shirt.png',
    'assets/pants.png',
    'assets/dress.png',
    'assets/shirt.png',

    // Add more image URLs as needed.
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
  @override
  void initState() {
    super.initState();
    fetchCarouselData().then((items) {
      setState(() {
        carouselItems = items;
      });
    }); // Call the function to fetch carousel data
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
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
                      SizedBox(width: 10),
                      Text(
                        'Search Your Favorite...',
                        style: content1,
                      )
                    ],
                  ),
                  // child: TextField(
                  //   readOnly: true,
                  //   decoration: InputDecoration(
                  //     fillColor: bgcolor,
                  //     filled: true,
                  //       isDense: true,
                  //       prefixIcon: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: SvgPicture.asset('assets/icons/Search.svg',height: 20,width: 20,),
                  //       ),
                  //       prefixIconConstraints:
                  //           BoxConstraints(minHeight: 28, minWidth: 28),
                  //       hintText: 'Search Your Favorite...',
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)))),
                  // ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(minimumSize: Size(25, 25)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishList()));
              },
              child: Image.asset(
                'assets/icons/heart.png',
                height: 25,
                width: 25,
              )),
          TextButton(
              style: TextButton.styleFrom(minimumSize: Size(25, 25)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen(image: '', title: '', size: '', price: '', counter: 0,)));
              },
              child: Image.asset(
                'assets/icons/shoppingbag.png',
                height: 25,
                width: 25,
              ))
        ],
      ),
      mainChild: CustomScrollView(
        slivers: [
          // sliver app bar

          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            expandedHeight: 330,
            pinned: false,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              collapseMode: CollapseMode.parallax,
              title: Container(),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: imgList.map((item) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
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
                      
                      autoPlay: true,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category', style: subtitle),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryPage()));
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: indicator),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 70, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 23, vertical: 0),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.25, color: Colors.grey),
                                    color: Colors.grey[350],
                                    shape: BoxShape.circle,
                                    // image: DecorationImage(
                                    //   image: Image.asset(imageUrls[index]),
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  child: Image.asset(
                                    imageUrls[index],
                                  ),
                                ),
                                SizedBox(
                                    height: 5), // Space between image and name
                                Text(imageNames[index]),
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
                child: Container(
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverGrid.builder(
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  crossAxisCount: 2,
                  mainAxisExtent: 241,
                ),
                itemBuilder: ((context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
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
                                              ProductDetail()));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/image.jpeg',
                                          fit: BoxFit.cover,
                                          height: 150,
                                          width: double.infinity,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            gradient: LinearGradient(
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
                            SizedBox(
                              height: 5,
                            ),
                            Text('T-shirt',
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 5),
                            Text("Tiger Image EZYE – Tees for Men"),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  '₹799',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.green[800],
                                      decorationColor: Colors.green[800],
                                      decorationThickness: 3),
                                ),
                                SizedBox(width: 5),
                                Text('- ₹399'),
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
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked = !isLiked;
                                      });
                                    },
                                    child: Image.asset(
                                      isLiked
                                          ? 'assets/icons/Comp 232.gif'
                                          : 'assets/icons/White heart.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Container(
                                //   padding: EdgeInsets.all(5),
                                //   decoration: BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       color: Colors.white),
                                //   child: GestureDetector(
                                //     onTap: () {},
                                //     child: Image.asset(
                                //       'assets/icons/shoppingbag.png',
                                //       height: 17,
                                //       width: 17,
                                //     ),
                                //   ),
                                // ),
                              ],
                            )),
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  Future<List<CarouselItem>> fetchCarouselData() async {
    final Uri apiUrl =
        Uri.parse('https://ezys.in/customerApp/getActiveSliders.php');

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => CarouselItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load carousel data');
    }
  }
}

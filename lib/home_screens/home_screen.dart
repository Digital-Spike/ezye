import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ezye/home_screens/category_screen.dart';
import 'package:ezye/home_screens/main_screen.dart';
import 'package:ezye/home_screens/product_list.dart';
import 'package:ezye/home_screens/product_screen.dart';
import 'package:ezye/home_screens/search_screen.dart';
import 'package:ezye/paymentScreens/wallet_screen.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<String> sliderImageList = [];
  final List<String> categoriesList = [];
  final List<String> category = [
    'Category1',
    'Category2',
    'Category3',
    'Category4',
    'Category5',
  ];

  final List<String> grid = [
    'assets/png/grid.png',
    'assets/png/grid1.png',
    'assets/png/grid1.png',
    'assets/png/grid.png'
  ];

  final List<String> listv = [
    'assets/png/list.png',
    'assets/png/list1.png',
    'assets/png/list.png',
  ];

  late Future<void> homeContentFuture;
  Map<String, dynamic> homeContent = {};

  @override
  void initState() {
    homeContentFuture = getHomeContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.asset(
              'assets/png/Ezyelogo.png',
              height: 26,
            ),
          ),
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationList()));
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
                    'assets/svg/notification.svg',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WalletPage()));
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
                    'assets/svg/wallet.svg',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: FutureBuilder<void>(
          future: homeContentFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1.5, color: const Color(0xffE8E9EE))),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/searching.svg'),
                            const SizedBox(width: 10),
                            const Text(
                              'Search product, category, etc',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffBDC1CA)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CarouselSlider(
                              items: (homeContent['sliderImages'] as List)
                                  .map((item) => InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductList(
                                                          searchText: item[
                                                              'category'])));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                                child: CachedNetworkImage(
                                              imageUrl:
                                                  '${ApiService.uploads}${item['imageUrl']}',
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
                                                  'assets/png/banner.png',
                                                  fit: BoxFit.fill,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5,
                                                  width: 1000,
                                                ),
                                              ),
                                              imageBuilder: (context, image) =>
                                                  Image(
                                                image: image,
                                                fit: BoxFit.fill,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                width: 1000,
                                              ),
                                            )),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  aspectRatio: 3 / 2,
                                  viewportFraction: 0.99,
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  autoPlay: true)),
                          Positioned(
                            bottom: 10,
                            child: DotsIndicator(
                              decorator: DotsDecorator(
                                  spacing: const EdgeInsets.all(2),
                                  color: const Color(0xffBDC1CA),
                                  size: const Size(8, 8),
                                  activeColor: Colors.white,
                                  activeSize: const Size(8, 8),
                                  activeShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              dotsCount: sliderImageList.length,
                              position: currentIndex,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen(indeX: 1)));
                            },
                            child: const Text(
                              'VIEW ALL',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff00CA14)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            itemCount: categoriesList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CategoryPage(
                                                category:
                                                    (homeContent['categories']
                                                            as List)[index]
                                                        ['subCategory'])));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 82,
                                        width: 82,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${ApiService.uploads}${categoriesList[index]}',
                                            placeholder: (context, url) =>
                                                const CircleAvatar(
                                              backgroundColor: Colors.white30,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Image.asset(
                                                  'assets/png/woman.png',
                                                  fit: BoxFit.cover),
                                            ),
                                            imageBuilder: (context, image) =>
                                                Image(
                                                    image: image,
                                                    fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text((homeContent['categories']
                                          as List)[index]['subCategory'])
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    /*const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Trending Now',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: sliderImageList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    sliderImageList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),*/
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Mega Sales',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: (homeContent['mega'] as List).length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 1 / 1.4,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                              productId: (homeContent['mega']
                                                          as List)[index]
                                                      ['productId'] ??
                                                  "",
                                            )));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${ApiService.uploads}${(homeContent['mega'] as List)[index]['image1Url']}',
                                    placeholder: (context, url) =>
                                        const CircleAvatar(
                                      backgroundColor: Colors.white30,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset('assets/png/woman.png',
                                          fit: BoxFit.cover),
                                    ),
                                    imageBuilder: (context, image) =>
                                        Image(image: image, fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Hand-Picked Collections',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: (homeContent['handPicks'] as List).length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductScreen(
                                              productId:
                                                  (homeContent['handPicks']
                                                              as List)[index]
                                                          ['productId'] ??
                                                      "",
                                            )));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${ApiService.uploads}${(homeContent['handPicks'] as List)[index]['image1Url']}',
                                    placeholder: (context, url) =>
                                        const CircleAvatar(
                                      backgroundColor: Colors.white30,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Image.asset('assets/png/grid.png',
                                          fit: BoxFit.cover),
                                    ),
                                    imageBuilder: (context, image) =>
                                        Image(image: image, fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Trending',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: (homeContent['trending'] as List).length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                  productId: (homeContent[
                                                                  'trending']
                                                              as List)[index]
                                                          ['productId'] ??
                                                      "",
                                                )));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${ApiService.uploads}${(homeContent['trending'] as List)[index]['image1Url']}',
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                          backgroundColor: Colors.white30,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Image.asset(
                                              'assets/png/flyer2.png',
                                              fit: BoxFit.cover),
                                        ),
                                        imageBuilder: (context, image) => Image(
                                            image: image, fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'Top Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Men',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            itemCount: (homeContent['Men'] as List).length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                                productId: (homeContent['Men']
                                                            as List)[index]
                                                        ['productId'] ??
                                                    "",
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 82,
                                        width: 82,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${ApiService.uploads}${(homeContent['Men'] as List)[index]['image1Url']}',
                                            placeholder: (context, url) =>
                                                const CircleAvatar(
                                              backgroundColor: Colors.white30,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Image.asset(
                                                  'assets/png/flyer2.png',
                                                  fit: BoxFit.cover),
                                            ),
                                            imageBuilder: (context, image) =>
                                                Image(
                                                    image: image,
                                                    fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text((homeContent['Men'] as List)[index]
                                          ['name'])
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Women',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            itemCount: (homeContent['Women'] as List).length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                                productId: (homeContent['Women']
                                                            as List)[index]
                                                        ['productId'] ??
                                                    "",
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 82,
                                        width: 82,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${ApiService.uploads}${(homeContent['Women'] as List)[index]['image1Url']}',
                                            placeholder: (context, url) =>
                                                const CircleAvatar(
                                              backgroundColor: Colors.white30,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Image.asset(
                                                  'assets/png/flyer2.png',
                                                  fit: BoxFit.cover),
                                            ),
                                            imageBuilder: (context, image) =>
                                                Image(
                                                    image: image,
                                                    fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text((homeContent['Women'] as List)[index]
                                          ['name'])
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Kids',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            itemCount: (homeContent['Kids'] as List).length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                                productId: (homeContent['Kids']
                                                            as List)[index]
                                                        ['productId'] ??
                                                    "",
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 82,
                                        width: 82,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${ApiService.uploads}${(homeContent['Kids'] as List)[index]['image1Url']}',
                                            placeholder: (context, url) =>
                                                const CircleAvatar(
                                              backgroundColor: Colors.white30,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Image.asset(
                                                  'assets/png/flyer2.png',
                                                  fit: BoxFit.cover),
                                            ),
                                            imageBuilder: (context, image) =>
                                                Image(
                                                    image: image,
                                                    fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text((homeContent['Kids'] as List)[index]
                                          ['name'])
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    /*const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Kids',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            itemCount: categoriesList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 82,
                                      width: 82,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Image.asset(
                                        categoriesList[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(category[index])
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Hand-Picked Collections',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: listv.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      listv[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text('Hand-Picked Collections',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: grid.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 1 / 1.25,
                                  mainAxisSpacing: 15,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.asset(
                                  grid[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 20)*/
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return const Text('Something wrong. Please try again later');
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<void> getHomeContent() async {
    try {
      var url = Uri.parse('${ApiService.url}homepage.php');
      var response = await http.post(url, body: {});

      homeContent =
          json.decode((response.body).toString().replaceAll('connected', ''));

      for (var element in (homeContent['sliderImages'] as List)) {
        sliderImageList.add(element['imageUrl']);
      }

      for (var element in (homeContent['categories'] as List)) {
        categoriesList.add(element['imageUrl']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

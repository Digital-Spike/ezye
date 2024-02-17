import 'dart:convert';

import 'package:ezye/home_screens/home_grid_view.dart';
import 'package:ezye/home_screens/home_list_view.dart';
import 'package:ezye/home_screens/home_slider.dart';
import 'package:ezye/home_screens/search_screen.dart';
import 'package:ezye/model/home_list.dart';
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
  List<HomeList> homeList = [];
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
              return Column(
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListView.builder(
                          itemCount: homeList.length,
                          itemBuilder: (context, index) {
                            return homeItemView(homeList[index]);
                          }),
                    ),
                  ),
                ],
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

      homeList = (json.decode(response.body) as List)
          .map((e) => HomeList.fromJson(e))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget homeItemView(HomeList homeList) {
    if ((homeList.bannerStyle ?? '').toLowerCase() == 'slider') {
      return HomeSlider(homeList: homeList);
    }

    if ((homeList.bannerStyle ?? '').toLowerCase() == 'listview') {
      return HomeListView(homeList: homeList);
    }

    if ((homeList.bannerStyle ?? '').toLowerCase() == 'gridview') {
      return HomeGridView(homeList: homeList);
    }

    return Container();
  }
}

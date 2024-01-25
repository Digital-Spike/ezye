import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ezye/home_screens/product_list.dart';
import 'package:ezye/model/home_list.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatefulWidget {
  final HomeList homeList;

  const HomeSlider({super.key, required this.homeList});

  @override
  State<StatefulWidget> createState() => HomeSliderState();
}

class HomeSliderState extends State<HomeSlider> {
  late HomeList homeList;
  int currentIndex = 0;

  @override
  void initState() {
    homeList = widget.homeList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider(
                  items: (homeList.items ?? [])
                      .map((item) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductList(
                                          searchText: item.category ?? '')));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: CachedNetworkImage(
                                  imageUrl:
                                      '${ApiService.uploads}${item.imageUrl}',
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    backgroundColor: Colors.white30,
                                  ),
                                  errorWidget: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Image.asset(
                                      'assets/png/banner.png',
                                      fit: BoxFit.fill,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      width: 1000,
                                    ),
                                  ),
                                  imageBuilder: (context, image) => Image(
                                    image: image,
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: 1000,
                                  ),
                                )),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 5,
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
                          borderRadius: BorderRadius.circular(5.0))),
                  dotsCount: (homeList.items ?? []).length,
                  position: currentIndex,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

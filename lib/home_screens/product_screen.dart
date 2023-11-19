import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ezye/model/product.dart';
import 'package:ezye/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];
  bool wishList = false;
  bool addToCart = false;
  bool selectedSize = false;
  String size = '';
  int? _value = -1;
  List<String> imgList = [];
  int currentIndex = 0;
  List<Color> colors = [
    const Color(0xff243B4C),
    const Color(0xff000000),
    const Color(0xff8C969D),
  ];
  int selectedColorIndex = 0;
  List<String> sizes = ['S', 'M', 'L', 'XL'];
  List<String> colorNames = [
    'Blue',
    'Black',
    'Grey',
  ];
  String? selectedColorName;
  void selectColor(int index) {
    setState(() {
      selectedColorIndex = index;
      selectedColorName = colorNames[index];
    });
  }

  int counter = 0;
  int count = 0;
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
      if (count < 1) {
        addToCart = !addToCart;
      }
    });
  }

  Future<bool>? listItems;
  @override
  void initState() {
    listItems = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.2)),
            child: const BackButton()),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.2)),
            child: SvgPicture.asset(
              'assets/svg/heart.svg',
              height: 25,
              width: 25,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.2)),
            child: SvgPicture.asset('assets/svg/cart.svg'),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor:
                            wishList ? Colors.white : const Color(0xff00CA14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: const Size(double.infinity, 56),
                        side: BorderSide(
                            width: 1.5,
                            color: wishList
                                ? Colors.black
                                : const Color(0xff00CA14))),
                    onPressed: () {
                      setState(() {
                        wishList = !wishList;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/heart.svg',
                          color: wishList ? Colors.black : Colors.white,
                        ),
                        Text(
                          wishList ? ' Wishlist' : ' Added',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: wishList ? Colors.black : Colors.white),
                        ),
                      ],
                    )),
              ),
              const SizedBox(width: 20),
              if (addToCart == false)
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 56),
                          side: const BorderSide(
                              width: 1.5, color: Colors.black)),
                      onPressed: () {
                        setState(() {
                          addToCart = !addToCart;
                          incrementCounter();
                        });
                      },
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )),
                ),
              if (addToCart == true)
                Expanded(
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border:
                          Border.all(width: 0.1, color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              decrementCounter();
                            },
                            child: SvgPicture.asset(
                              'assets/svg/minus.svg',
                              height: 50,
                            )),
                        Text(
                          count.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        GestureDetector(
                            onTap: () {
                              incrementCounter();
                            },
                            child: SvgPicture.asset(
                              'assets/svg/add.svg',
                              height: 50,
                            )),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<bool>(
          future: listItems,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (products.isNotEmpty) {
                return SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.9,
                          width: double.infinity,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemCount: imgList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${ApiService.uploads}${imgList[index]}',
                                  placeholder: (context, url) =>
                                      const CircleAvatar(
                                    backgroundColor: Colors.white30,
                                  ),
                                  errorWidget: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Image.asset(
                                      'assets/png/cloth.png',
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
                              );
                            },
                          ),
                        ),
                        Positioned(
                            left: MediaQuery.of(context).size.width / 2.5,
                            bottom: 10,
                            child: DotsIndicator(
                              decorator: DotsDecorator(
                                  color: Colors.white.withOpacity(0.3),
                                  activeColor: Colors.white),
                              dotsCount: imgList.length,
                              position: currentIndex,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black),
                            child: const Text(
                              'EZYE',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            products.first.name ?? '',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '₹${products.first.mrp}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff7C7D85),
                                    decoration: TextDecoration.lineThrough),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '₹${products.first.sellingPrice}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff00CA14)),
                                child: const Text(
                                  '10% Off',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Colors',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 90,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectColor(index);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 65,
                                        padding: const EdgeInsets.all(4),
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: selectedColorIndex == index
                                              ? Border.all(
                                                  color: Colors
                                                      .black, // Add your desired stroke color
                                                  width:
                                                      1.5, // Adjust the stroke width as needed
                                                )
                                              : null,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),

                                            color: colors[index],
                                            // No border when not selected
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        colorNames[index],
                                        style: TextStyle(
                                            color: selectedColorIndex == index
                                                ? const Color(0xff040707)
                                                : const Color(0xff7C7D85)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Sizes',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(
                              height: 50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sizes.length,
                                itemBuilder: (context, index) {
                                  return ChoiceChip(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    label: Container(
                                      height: 30,
                                      width: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        sizes[index],
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                        color: _value == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16),
                                    selected: _value == [index],
                                    backgroundColor: _value == index
                                        ? Colors.black
                                        : const Color(0xffE8E9EE),
                                    onSelected: (selected) {
                                      setState(() {
                                        _value = index;
                                      });
                                    },
                                  );
                                },
                              )),
                          const SizedBox(height: 5),
                          const Text('About Product',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 5),
                          Text(
                            '${products.first.fullDescription}',
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xff3E3E41)),
                            textAlign: TextAlign.justify,
                          )
                        ],
                      ),
                    )
                  ],
                ));
              } else {
                return const Text(
                    "Something went wrong. Please try again later");
              }
            }

            if (snapshot.hasError || snapshot.data == false) {
              return const Text("Something went wrong. Please try again later");
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<bool> fetchData() async {
    try {
      var productUrl = Uri.parse('${ApiService.url}/getProductDetails.php');
      var response =
          await http.post(productUrl, body: {"productId": widget.productId});

      if (response.statusCode == 200) {
        products = (json.decode(response.body) as List)
            .map((item) => Product.fromJson(item))
            .toList();
        if ((products.first.image1Url ?? '').isNotEmpty) {
          imgList.add(products.first.image1Url ?? '');
        }
        if ((products.first.image2Url ?? '').isNotEmpty) {
          imgList.add(products.first.image2Url ?? '');
        }
        if ((products.first.image3Url ?? '').isNotEmpty) {
          imgList.add(products.first.image3Url ?? '');
        }
        if ((products.first.image4Url ?? '').isNotEmpty) {
          imgList.add(products.first.image4Url ?? '');
        }
        if ((products.first.image5url ?? '').isNotEmpty) {
          imgList.add(products.first.image5url ?? '');
        }
      }
      return true;
    } catch (error) {
      print('Error: $error');
    }
    return false;
  }
}

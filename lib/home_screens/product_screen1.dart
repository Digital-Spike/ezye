import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool wishList = false;
  bool addtoCart = false;
  bool selectedSize = false;
  String size = '';
  int? _value = -1;
  final List<String> imgList = [
    'assets/png/man.png',
    'assets/png/pant.png',
    'assets/png/shirt.png',
    'assets/png/man.png'
  ];
  int currenIndex = 0;
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
        addtoCart = !addtoCart;
      }
    });
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
                            wishList ? Colors.white : Color(0xff00CA14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: const Size(double.infinity, 56),
                        side: BorderSide(
                            width: 1.5,
                            color:
                                wishList ? Colors.black : Color(0xff00CA14))),
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
              if (addtoCart == false)
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
                          addtoCart = !addtoCart;
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
              if (addtoCart == true)
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
      body: SingleChildScrollView(
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
                      currenIndex = index;
                    });
                  },
                  itemCount: imgList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Image.asset(
                          imgList[index],
                          fit: BoxFit.fill,
                        ));
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
                    position: currenIndex,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Men Blue Washed Denim Jacket',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      '₹ 2,199',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff7C7D85),
                          decoration: TextDecoration.lineThrough),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      '₹2,000',
                      style: TextStyle(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                                borderRadius: BorderRadius.circular(10),
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
                                  borderRadius: BorderRadius.circular(5),

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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
                              color:
                                  _value == index ? Colors.white : Colors.black,
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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                const Text(
                  'Lorem ipsum dolor sit amet consectetur. Porta sagittis in sit id nunc risus est et pharetra. Consectetur pharetra tellus neque morbi venenatis. Eget ipsum massa nam neque eget ullamcorper convallis dignissim enim. Commodo amet purus augue mauris arcu id vulputate mattis. Sit viverra urna vitae dictumst est. Urna quis ac velit lectus. Mattis tortor a imperdiet cursus amet purus aliquet velit pretium. Quisque turpis vitae dictum cum. In at eu auctor eget. Pretium vestibulum consequat facilisi mi dignissim tristique amet dui scelerisque. Et tortor amet gravida eu augue nulla amet sed semper. Eu proin eget diam hendrerit duis a venenatis scelerisque. Turpis sit ornare amet integer.',
                  style: TextStyle(fontSize: 14, color: Color(0xff3E3E41)),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

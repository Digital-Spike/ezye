import 'package:ezys/custom_widgets/constants.dart';
import 'package:ezys/custom_widgets/multiselectchoicechip_widget.dart';
import 'package:ezys/custom_widgets/persistentheader.dart';
import 'package:ezys/home_screens/main_screen.dart';
import 'package:ezys/home_screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  bool isLiked = false;
  int counter = 0;
  List<String> subcategory = [];

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
        mainChild: CustomScrollView(
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
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    mainAxisExtent: 241,
                  ),
                  itemBuilder: ((context, index) {
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
                                                const ProductDetail()));
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
                                              gradient: const LinearGradient(
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
                              const Text('T-shirt',
                                  style: TextStyle(color: Colors.grey)),
                              const SizedBox(height: 5),
                              const Text("Tiger Image EZYE – Tees for Men"),
                              const SizedBox(height: 5),
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
                                  const SizedBox(width: 5),
                                  const Text('- ₹399'),
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
                                  const SizedBox(height: 10),
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
        ));
  }
}

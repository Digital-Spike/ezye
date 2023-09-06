import 'package:ezys/main_screen.dart';
import 'package:ezys/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    
    'assets/1.png',

  ];
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 45,
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Your Favorite...',
                    border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(minimumSize: Size(25, 25)),
              onPressed: () {},
              child: Image.asset(
                'assets/icons/heart.png',
                height: 25,
                width: 25,
              )),
          TextButton(
              style: TextButton.styleFrom(minimumSize: Size(25, 25)),
              onPressed: () {},
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
            elevation: 0,
            automaticallyImplyLeading: false,
            expandedHeight: 360,
            floating: false,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              collapseMode: CollapseMode.parallax,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Selling Products",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'See more',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              background: Column(
                children: [
                 
                  CarouselSlider(
                              items: imgList
                                  .map((item) => Container(
                                //  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Center(
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover,
                                      height: 250,
                                      width: 1000,
                                    )),
                              ))
                                  .toList(),
                              options: CarouselOptions(
                                  height: 250,
                                 
                                  viewportFraction: 1.09,
                                 
                                  autoPlay: true)),
                                  Container(height: 80,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 10),
                                         child: Text('Categories',style: TextStyle(fontWeight: FontWeight.w600),),
                                       ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                         
                                          Column(
                                            children: [
                                              Image.asset('assets/Men.png',height: 40,width: 40,),
                                              Text('Men')
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset('assets/Women.png',height: 40,width: 40,),
                                              Text('Women')
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset('assets/Junior.png',height: 40,width: 40,),
                                              Text('Juniors')
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset('assets/Kids.png',height: 40,width: 40,),
                                              Text('Kids')
                                            ],
                                          ),
                                          
                                        ],
                                      ),
                                     
                                    ],
                                  ),
                                  )
                ],
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
                    mainAxisExtent: 230),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        // border: Border.all(width: 0.25,color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        // image: DecorationImage(image: AssetImage('assets/image.jpeg'))
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: AssetImage('assets/image1.jpeg'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Tiger Image EZYE – Tees for Men"),
                              SizedBox(height: 5),
                              Text('₹399.00')
                            ],
                          ),
                          Positioned(
                              top: 5,
                              right: 5,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Image.asset(
                                      'assets/icons/heart.png',
                                      height: 17,
                                      width: 17,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Image.asset(
                                      'assets/icons/shoppingbag.png',
                                      height: 17,
                                      width: 17,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                })),
          ),

          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       top: 20.0,
          //       left: 20,
          //       right: 20,
          //     ),
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(10),
          //       child: Container(
          //         color: Colors.deepPurple[400],
          //         height: 150,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

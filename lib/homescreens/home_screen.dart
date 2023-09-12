import 'package:ezys/homescreens/cart_screen.dart';
import 'package:ezys/homescreens/main_screen.dart';
import 'package:ezys/homescreens/product_detail_screen.dart';
import 'package:ezys/homescreens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLiked =false;
  final List<String> imgList = [
    
    'assets/ezye2.png',

  ];
   List<String> imageUrls = [
  'assets/t-shirt.png',
  'assets/pants.png',
  'assets/dress.png',
  'assets/shirt.png',
  'assets/pants.png',
  // Add more image URLs as needed.
];
final List<String> imageNames = [
    'T-shirts',
    'Pants',
    'Dress',
    'shirts',
     'Pants',
   
    
     
    // Add more image names corresponding to the URLs.
  ];
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
        backgroundColor: Colors.white,
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WishList()));
              },
              child: Image.asset(
                'assets/icons/heart.png',
                height: 25,
                width: 25,
              )),
          TextButton(
              style: TextButton.styleFrom(minimumSize: Size(25, 25)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
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
            expandedHeight: 390,
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
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'See more',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 9,
                        fontWeight: FontWeight.w600),
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
                                   Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Category',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                          Text('See all',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),)
                                        ],
                                      ),
                                    ),
                                    Container(
              height: 70, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                    child: Column(
                     
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.brown[100],
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //   image: Image.asset(imageUrls[index]),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          child: Image.asset(imageUrls[index],),
                        ),
                        SizedBox(height: 5), // Space between image and name
                        Text(imageNames[index]),
                      ],
                    ),
                  );
                },
              ),
            ),       
                                  SizedBox(height: 0,)
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
                    mainAxisExtent: 250),
                itemBuilder: ((context, index) {
                  return Container(
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail()));
                              },
                              child: Container(
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: AssetImage('assets/image1.jpeg'),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('T-shirt',style: TextStyle(color: Colors.grey)),
                            SizedBox(height: 3),
                            Text("Tiger Image EZYE – Tees for Men"),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Text('₹799',style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.green[800],decorationColor: Colors.green[800],decorationThickness: 2),),SizedBox(width: 5),
                                Text('- ₹399'),
                              ],
                            )
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
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLiked=!isLiked;
                                      });
                                      
                                    },
                                    child: Image.asset(isLiked?
                                      'assets/icons/heart (2).png':'assets/icons/heart (1).png',
                                      height: 17,
                                      width: 17,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: GestureDetector(
                                    onTap: () {
                                      
                                    },
                                    child: Image.asset(
                                      'assets/icons/shoppingbag.png',
                                      height: 17,
                                      width: 17,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezys/cart_screen.dart';
import 'package:ezys/product_detail_screen.dart';
import 'package:ezys/wishlist_screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  String? filters;
   final List<String> imgList = [
    
    'assets/1.png',

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
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 0.5,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                                   
                                    viewportFraction: 1,
                                   
                                    autoPlay: true)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Category',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                          Text('See all',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),)
                                        ],
                                      ),
                                    ),
                            Container(
              height: 100, // Adjust the height as needed
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
                        SizedBox(height: 8), // Space between image and name
                        Text(imageNames[index]),
                      ],
                    ),
                  );
                },
              ),
            ),              
             Row(
               children: [
                 Text('Flash Sale',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                 
               ],
             ),
              Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: Wrap(spacing: 10, children: [
                                              ChoiceChip(
                                              backgroundColor: Colors.grey,
                                              selectedColor: Colors.blueGrey,
                                              label: const Text(
                                                'All',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              selected:
                                                  filters == 'All',
                                              onSelected: (selected) {
                                                setState(() {
                                                  filters = selected
                                                      ? 'All'
                                                      : '';
                                                });
                                              },
                                              ),
                                              ChoiceChip(
                                               
                                                
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'Latest',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    filters == 'Latest',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    filters = selected
                                                        ? 'Latest'
                                                        : '';
                                                  });
                                                },
                                              ),
                                              ChoiceChip(
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'Hot Deals',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    filters == 'Hot Deals',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    filters = selected
                                                        ? 'Hot Deals'
                                                        : '';
                                                  });
                                                },
                                              ),
                                              ChoiceChip(
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'Man',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    filters == 'Man',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    filters = selected
                                                        ? 'Man'
                                                        : '';
                                                  });
                                                },
                                              ),
                                              ChoiceChip(
                                                backgroundColor: Colors.grey,
                                                selectedColor: Colors.blueGrey,
                                                label: const Text(
                                                  'Woman',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                selected:
                                                    filters == 'Woman',
                                                onSelected: (selected) {
                                                  setState(() {
                                                    filters = selected
                                                        ? 'Woman'
                                                        : '';
                                                  });
                                                },
                                              ),
                                            ]),
                                          ),
                                          Expanded(
                                            child: GridView.builder(itemCount: 8,
                                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                              mainAxisSpacing: 15,
                                                              crossAxisSpacing: 15,
                                                              crossAxisCount: 2,
                                                              mainAxisExtent: 250),
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
                                          )

          ],
        ),
      ),
    );
  }
}
import 'package:ezys/main_screen.dart';
import 'package:flutter/material.dart';
class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedThumbnailIndex = 0; // Track the selected thumbnail index

  List<String> clothingImages = [
    'assets/image.jpeg',
    'assets/image1.jpeg',
    'assets/image.jpeg',
    'assets/image1.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
       
        actions: [
          TextButton(onPressed: (){}, child: Image.asset('assets/icons/heart.png',height: 25,width: 25,)),TextButton(onPressed: (){}, child: Icon(Icons.share,color: Colors.black,)),TextButton(onPressed: (){}, child: Image.asset('assets/icons/shoppingbag.png',height: 25,width: 25,))
        ],
      ),
      mainChild: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
             Stack(
          children: [
            // Main clothing image
            GestureDetector(
              onTap: () {
                // Handle tapping on the main image (optional)
              },
              child: Image.asset(
                clothingImages[selectedThumbnailIndex],
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            // Small thumbnail images stacked on top-left
            Positioned(
              top: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: clothingImages.asMap().entries.map((entry) {
                  final index = entry.key;
                  final imagePath = entry.value;
        
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedThumbnailIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedThumbnailIndex == index
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
            ),
            Divider(height: 0.25,color: Colors.grey,),
          Container(
            color: Colors.white,
            height: 500,
          )
            ],
          ),
        ),
      ));
  }
}
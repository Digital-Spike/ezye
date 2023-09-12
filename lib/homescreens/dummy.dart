import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({super.key});

  @override
  State<DummyPage> createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  int selectedThumbnailIndex = 0;

  List<String> clothingImages = [
    'assets/t.jpg',
    'assets/t1.jpg',
    'assets/t2.jpg',
    'assets/t3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Main clothing image (swipeable)
          Container(
            width: double.infinity,
            height: 400,
            child: GestureDetector(
              onTap: () {
                // Handle tapping on the main image (optional)
              },
              
              child: PhotoView(
                imageProvider: AssetImage(
                  clothingImages[selectedThumbnailIndex],
                ),
              ),
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
                            ? Colors.orange
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
    );
  }
}

import 'package:ezye/custom_widgets/constants.dart';
import 'package:ezye/custom_widgets/multiselectchoicechip_widget.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> category = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.category, style: apptitle),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Expanded(
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
                          category = selectedOptions;
                        });
                      },
                    );
                  }),
            )),
      ),
    );
  }
}

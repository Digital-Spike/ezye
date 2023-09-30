import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.category,style: apptitle),
        centerTitle: true,
        leading: BackButton(color: Colors.black,),
        elevation: 0,
      ),
    );
  }
}
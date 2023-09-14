import 'package:flutter/material.dart';
class CustomSnack extends StatelessWidget {
  final String snackcontent;
  final String imagePath;
  const CustomSnack({super.key,required this.snackcontent,required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),image: DecorationImage(image: AssetImage(imagePath),fit: BoxFit.contain,)),
      child: Center(child:Text(snackcontent,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black),))
    );
  }
}
import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
class Status extends StatelessWidget {
  final String heading;
  final String subtitle;
  final IconData trailingIcon;
  const Status({super.key,required this.heading,required this.subtitle,required this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,style: title,
                
              ),
              SizedBox(height: 5,),
              Text(subtitle)
            ],
          ),
          Icon(trailingIcon)
        ],
      ),
    );
  }
}
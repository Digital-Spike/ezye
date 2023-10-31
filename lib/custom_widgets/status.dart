import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Status extends StatelessWidget {
  final String heading;
  final String subtitle;
  final String svgpath;

  const Status({
    super.key,
    required this.heading,
    required this.subtitle,
    required this.svgpath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: title,
              ),
              SizedBox(
                height: 5,
              ),
              Text(subtitle)
            ],
          ),
          SvgPicture.asset(
            svgpath,
            height: 25,
            width: 25,
          )
        ],
      ),
    );
  }
}

import 'package:ezye/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String title1;

  final String svgPath;

  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.title1,
    required this.svgPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 30),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            svgPath,
            height: 23,
            width: 23,
          ),
          const SizedBox(width: 10),
          Text(
            title1,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

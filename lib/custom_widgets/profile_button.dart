import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomButton extends StatelessWidget {
  final String title1;
  
  final String svgPath;
  
  final IconData trailingIcon;
  final VoidCallback onPressed;

  const CustomButton({super.key, 
    required this.title1,
   
    required this.svgPath,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 40),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
       
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      ),
      child: Row(
        children: [
        SvgPicture.asset(svgPath,height: 30,width: 30,),
          SizedBox(width: 20),
          Text(
            title1,
            style: title,
          ),
          Spacer(),
          Icon(
            trailingIcon,
            size: 26,color: Colors.black,
          ),
        ],
      ),
    );
  }
}

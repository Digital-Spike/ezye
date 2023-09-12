import 'package:ezys/custom_widgets/constants.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String title1;
  
   final IconData leadingIcon;
  
  final IconData trailingIcon;
  final VoidCallback onPressed;

  CustomButton({
    required this.title1,
   
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
       
        padding: EdgeInsets.all(10),
      ),
      child: Row(
        children: [
        Icon(leadingIcon,color: Colors.black,size: 26,),
          SizedBox(width: 16),
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

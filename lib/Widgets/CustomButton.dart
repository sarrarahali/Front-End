import 'package:flutter/material.dart';
import 'package:get/get.dart';
/*
class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final ImageProvider? image;

  const CustomButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.borderRadius = 100.0, // Set a default value for borderRadius
    this.image, required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size.fromHeight(60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          if (image != null)
            Positioned.fill(
             left: 10,
           
              child: Image(
                image: image!,
                fit: BoxFit.fitHeight ,
              height: 40,
              ),
            ),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final ImageProvider? image;

  const CustomButton({
    required this.title,
    required this.onPressed,
    required this.color,
    this.borderRadius = 100.0,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size.fromHeight(60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null) // Display image if provided
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Image(
                image: image!,
                fit: BoxFit.contain,
                height: 22, 
               
              ),
            ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

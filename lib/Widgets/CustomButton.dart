import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              right: 50,
              child: Image(
                image: image!,
                fit: BoxFit.cover,
                height: 30,
              ),
            ),
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white ),
          ),
        ],
      ),
    );
  }
}

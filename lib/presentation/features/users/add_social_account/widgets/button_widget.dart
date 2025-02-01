import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed;
  final Color backColor;
  final double borderWidth;
  final double borderRadius;

  // Constructor for the ButtonWidget widget
  ButtonWidget({
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
    this.backColor = Colors.blue,
    this.borderWidth = 2.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,  // Capture tap event
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backColor, // Background color
          border: Border.all(
            color: Colors.transparent, // Border color (transparent in this case)
            width: borderWidth, // Border width
          ),
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Ensures the button doesn't take up too much space
          children: [
            SizedBox(width: 10    ,),
            Image.asset(
              imagePath, // Image path passed as an argument
              height: 24, // Image size
              width: 24,  // Image size
            ),
            SizedBox(width: 8), // Space between the image and text
            Text(
              buttonText, // Button text
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

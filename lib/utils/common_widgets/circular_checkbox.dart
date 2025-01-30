import 'package:flutter/material.dart';

class JCircularCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;
  final double radius;  // Radius for the circular container
  final Color borderColor; // Border color of the circle
  final Color checkColor; // Checkmark color
  final Color fillColor; // Fill color for the circle

  const JCircularCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
    required this.radius,
    this.borderColor = Colors.black,  // Default border color
    this.checkColor = Colors.white,   // Default checkmark color
    this.fillColor = Colors.green,    // Default fill color when checked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);  // Toggle the checkbox when tapped
      },
      child: Container(
        width: radius * 2,  // Double the radius for the full circle size
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,  // Set the border color
            width: 2.0,  // Set border width
          ),
          color: isChecked ? fillColor : Colors.transparent, // Circle fill color
        ),
        child: Center(
          child: isChecked
              ? Icon(
            Icons.check,
            color: checkColor,  // Set the color of the check mark
            size: radius,  // Size of the checkmark
          )
              : null,  // No icon when unchecked
        ),
      ),
    );
  }
}

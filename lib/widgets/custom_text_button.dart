import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key, 
    required this.text, 
    required this.onPressed,  
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF1D2C33), // Accent color for buttons
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed, 
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // Text color for the button
        ),  
      ),
    );
  }
}
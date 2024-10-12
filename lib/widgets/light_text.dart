import 'package:flutter/material.dart';

class LightText extends StatelessWidget{
  final double size;
  final String font;
  final String text;
  final Color? color;
  final TextAlign align;
  final TextOverflow textOverflow;

  const LightText({
    super.key, 
    this.size = 15,
    this.font = "font30", 
    required this.text, 
    this.color, 
    this.align = TextAlign.center,
    this.textOverflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: textOverflow,
      text,
      textAlign: align,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: color,
        fontFamily: font
      ),
    );
  }
}
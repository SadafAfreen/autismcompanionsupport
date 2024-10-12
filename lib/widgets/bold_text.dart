import 'package:flutter/cupertino.dart';

class BoldText extends StatelessWidget {
  final double size;
  final String font;
  final String text;
  final Color? color;
  final TextAlign? align;
  final TextOverflow textOverflow;
  
  const BoldText({
    super.key, 
    this.size = 20,
    this.font = "font30", 
    required this.text, 
    this.color, 
    this.align,
    this.textOverflow = TextOverflow.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: textOverflow,
      text,
      textAlign: align,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: color,
        fontFamily: font
      ),
    );
  }

}
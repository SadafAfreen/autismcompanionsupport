import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget{
  final String text;
  final IconData icon;
  final Color? textColor;
  final Color? iconColor;
  final double textSize;
  final double iconSize;

  const IconWithText({
    super.key, 
    this.textColor = AppColors.blackColor,
    required this.icon,
    this.iconColor = AppColors.blackColor,
    this.textSize = 10,
    this.iconSize = 10,
    required this.text
    });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        const SizedBox(width: 10,),
        Opacity(
          opacity: 0.5,
          child: BoldText(
            size: textSize,
            text: text,
            color: textColor
          ),
        )
      ],
    );
  }

}
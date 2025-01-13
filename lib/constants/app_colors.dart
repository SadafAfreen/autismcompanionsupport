import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF7B43F);
  static const Color textColorBlack = Color(0xFF1D2C33);
  
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;

  static const Color textFieldWhite = Color(0xFFF4FBFF);
  static const Color switchGreyColor = Colors.grey;

  static WidgetStateProperty<Color?> trackColor = 
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if(states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return null;
      });

  static WidgetStateProperty<Color?> overlayColor = 
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if(states.contains(WidgetState.selected)) {
          return AppColors.primaryColor.withOpacity(0.54);
        }
        if(states.contains(WidgetState.disabled)) {
          return AppColors.textFieldWhite;
        }
        return null;
      });
}
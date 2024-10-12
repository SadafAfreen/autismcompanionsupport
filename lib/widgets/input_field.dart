import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/widgets/icon_with_text.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final String placeholder;
  final IconData? icon;
  final TextEditingController controller;
  final TextInputType type;
  final bool isProtected;

  const InputField({
    super.key,
    required this.placeholder,
    required this.controller,
    this.icon,
    this.type = TextInputType.text,
    this.isProtected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
            controller: controller,
            keyboardType: type,
            enableSuggestions: false,
            obscureText: isProtected,
            autocorrect: false,
            decoration: InputDecoration(
                label: icon!= null 
                  ? IconWithText(
                    iconSize: 30,
                    textSize: 15,
                    icon: icon!, 
                    text: placeholder,
                  ) : Text(placeholder),
              filled: true,
              fillColor: AppColors.textFieldWhite.withOpacity(0.54), // Secondary color for text fields
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
          );
  }
}
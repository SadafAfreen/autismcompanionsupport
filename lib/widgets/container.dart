import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final double? margin;
  final Color? color;
  final Widget? child;
  final String? fileName;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    this.radius = 0.0,
    this.color,
    this.fileName,
    this.child,
    this.margin = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            height: height,
            width: width,
            margin: EdgeInsets.symmetric(vertical: margin!),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radius!),
              image: fileName != null 
                ? DecorationImage(
                    image: AssetImage('assets/images/$fileName'),
                    fit: BoxFit.cover,
                  )
                : null,
            ),
            child: Center(child: child),
          );
  }
}
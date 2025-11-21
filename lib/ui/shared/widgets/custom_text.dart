import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.isDarkMode = false,
    this.color = Colors.white,
  });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isDarkMode;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: isDarkMode ? Theme.of(context).colorScheme.onPrimary : color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

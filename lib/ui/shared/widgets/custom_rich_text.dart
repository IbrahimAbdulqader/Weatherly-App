import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.generalTextStyle,
    required this.textChildren,
  });

  final TextStyle generalTextStyle;
  final List<InlineSpan> textChildren;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(style: generalTextStyle, children: textChildren),
    );
  }
}

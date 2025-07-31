import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

class TextCell extends StatelessWidget {
  const TextCell({super.key, required this.text, this.isTitle, this.color});

  final String text;
  final bool? isTitle;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          isTitle == true
              ? CustomTextWidget(
                text: text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextWidget(
                    text: text,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CircleAvatar(backgroundColor: color, radius: 5),
                  ),
                ],
              ),
    );
  }
}

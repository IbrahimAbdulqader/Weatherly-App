import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/widgets/custom_text.dart';

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
              ? CustomText(
                isDarkMode: true,
                text: text,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    isDarkMode: true,
                    text: text,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: CircleAvatar(backgroundColor: color, radius: 5.r),
                  ),
                ],
              ),
    );
  }
}

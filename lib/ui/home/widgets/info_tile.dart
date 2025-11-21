import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/widgets/custom_text.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    this.iconButton,
    required this.title,
    required this.info,
  });
  final String title;
  final String info;
  final Widget? iconButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 12.w),
      child: Column(
        children: [
          Row(
            children: [
              iconButton ?? Container(),
              CustomText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
              const Spacer(),
              CustomText(
                text: info,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Divider(color: Colors.white12, height: 2.h),
        ],
      ),
    );
  }
}

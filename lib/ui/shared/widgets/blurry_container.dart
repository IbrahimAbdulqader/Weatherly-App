import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlurryContainer extends StatelessWidget {
  const BlurryContainer({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.horizontalPadding,
  });
  final double width;
  final double height;
  final Widget child;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.r,
        horizontal: horizontalPadding ?? 0,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),

          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[400]!.withValues(alpha: 0.125),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

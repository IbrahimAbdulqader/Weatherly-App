import 'dart:ui';
import 'package:flutter/material.dart';

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
        vertical: 5,
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
              borderRadius: BorderRadius.circular(12),
              // border: Border.all(
              //   width: 0.5,
              //   color: Colors.white.withValues(alpha: 0.25),
              // ),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   stops: const [0, 0.85],
              //   colors: [
              //     Colors.grey.withValues(alpha: 0.3),
              //
              //     Colors.grey.withValues(alpha: 0.05),
              //   ],
              // ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

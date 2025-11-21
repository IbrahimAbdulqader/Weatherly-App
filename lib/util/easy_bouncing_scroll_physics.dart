import 'package:flutter/material.dart';

class EasyBouncingScrollPhysics extends BouncingScrollPhysics {
  const EasyBouncingScrollPhysics({super.parent});

  @override
  double get dragStartDistanceMotionThreshold => 3.5;

  @override
  double get minFlingDistance => 5.0;
  @override
  double get minFlingVelocity => 200.0;

  @override
  EasyBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return EasyBouncingScrollPhysics(parent: buildParent(ancestor));
  }
}

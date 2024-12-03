import 'package:flutter/material.dart';

class AnimatedNestedContainer extends StatelessWidget {
  const AnimatedNestedContainer({
    required this.translateAnimValue,
    required this.child,
    super.key,
  });

  final double translateAnimValue;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(translateAnimValue * 350, 0),
      child: child,
    );
  }
}

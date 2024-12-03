import 'dart:ui';

import 'package:flutter/material.dart';

class BluringFilter extends StatelessWidget {
  const BluringFilter({required double blurAnimationValue, super.key})
      : _blurAnimationValue = blurAnimationValue;

  final double _blurAnimationValue;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: _blurAnimationValue * 15,
        sigmaY: _blurAnimationValue * 15,
      ),
      child: Container(
        color: Colors.transparent,
      ),
    );
  }
}

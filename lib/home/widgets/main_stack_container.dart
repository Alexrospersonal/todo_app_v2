import 'package:flutter/material.dart';

class MainStackContainer extends StatelessWidget {
  const MainStackContainer({
    required this.selectedTabIndex,
    required this.translateAnimValue,
    required this.scaleAnimValue,
    required this.opacityAnimValue,
    required this.children,
    super.key,
  });

  final int selectedTabIndex;
  final double translateAnimValue;
  final double scaleAnimValue;
  final double opacityAnimValue;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(translateAnimValue * 180, 0),
      child: Transform.scale(
        scale: scaleAnimValue,
        child: Opacity(
          opacity: opacityAnimValue,
          child: IndexedStack(
            index: selectedTabIndex,
            children: children,
          ),
        ),
      ),
    );
  }
}

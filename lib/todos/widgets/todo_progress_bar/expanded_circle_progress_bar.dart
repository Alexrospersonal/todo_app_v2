import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/todos/widgets/widgets.dart';

class ExpandedCircleProgressBar extends StatefulWidget {
  const ExpandedCircleProgressBar({required this.percent, super.key});
  final double percent;

  @override
  State<ExpandedCircleProgressBar> createState() =>
      _ExpandedCircleProgressBarState();
}

class _ExpandedCircleProgressBarState extends State<ExpandedCircleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> gradientAnimation;
  late Animation<double> percentAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    final curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic);

    gradientAnimation = Tween<double>(begin: 0, end: pi * 2 * widget.percent)
        .animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    percentAnimation = Tween<double>(begin: 0, end: widget.percent * 100)
        .animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    final percentValue =
        percentAnimation.value.toInt().toString().padLeft(2, '0');

    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.14),
            child: CustomPaint(
              painter: AnimatedCircleProgressBar(
                value: gradientAnimation.value,
                percent: widget.percent,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$percentValue%',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                const Text(
                  // l10n.monthProgress,
                  'MonthProgress',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

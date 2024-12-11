import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:todo_app_v2/theme/theme.dart';

class AnimatedCircleProgressBar extends CustomPainter {
  const AnimatedCircleProgressBar({required this.value, required this.percent});
  final double value;
  final double percent;

  void addBaseStyleForCircle(Paint paint, Color color) {
    paint
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = 18;
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    const rect = Rect.fromLTRB(0, 0, 140, 140);
    final offset = const Offset(9, 9) & Size(size.width - 18, size.height - 18);

    final Gradient gradient = SweepGradient(
      colors: const [
        circleStatusBackgroundColor,
        primaryColorWithOpacity,
        primaryColor,
      ],
      stops: const [0.05, 0.15, 1],
      transform: GradientRotation(percent == 1 ? value - (pi / 2) : -1.75),
    );

    final filledPaint = Paint();
    addBaseStyleForCircle(
      filledPaint,
      circleStatusBackgroundColor,
    );
    canvas.drawArc(offset, -pi / 2, pi * 2, false, filledPaint);

    final circlePaint = Paint();
    addBaseStyleForCircle(circlePaint, Colors.black);
    circlePaint
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(rect);
    canvas.drawArc(offset, -pi / 2, value, false, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

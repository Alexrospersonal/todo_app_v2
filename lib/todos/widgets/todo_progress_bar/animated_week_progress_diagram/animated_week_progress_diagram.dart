import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:todo_app_v2/theme/theme.dart';
import 'package:todo_app_v2/todos/widgets/widgets.dart';

class AnimatedWeekProgressDiagramm extends CustomPainter {
  AnimatedWeekProgressDiagramm({required this.progressInWeek});
  final List<double> progressInWeek;
  final paintData = AnimatedWeekProgressDiagrammData();

  double calculatePercentage(double percent) {
    const minValue = 112.4; // 0%
    const maxValue = 10; // 100%

    final value = minValue + (maxValue - minValue) * (percent / 100);

    return value;
  }

  void drawDiagramLine(
    ui.Canvas canvas,
    Offset startPoint,
    Offset endPoint,
    Paint paint,
  ) {
    canvas.drawLine(
      startPoint,
      endPoint,
      paint,
    );
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final column = size.width / 4;
    final row = size.height / 5 - 1;
    final lineWidth = size.width - column;
    final weekColumn = lineWidth / 7 - (lineWidth / 110);

    final line = Paint()
      ..color = greyColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final diagramLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    drawDiagramPicks(
      column,
      weekColumn,
      size,
      row,
      diagramLine,
      paintData,
      canvas,
    );

    drawBackgroundGrid(paintData, column, size, row, canvas, line);

    canvas
      ..save()
      ..translate(size.width, size.height)
      ..rotate(-pi / 2);

    drawWeekDays(paintData, canvas, weekColumn);

    canvas.restore();
  }

  void drawBackgroundGrid(
    AnimatedWeekProgressDiagrammData paintData,
    double column,
    ui.Size size,
    double row,
    ui.Canvas canvas,
    ui.Paint line,
  ) {
    final percents = paintData.percents;
    final percentTextWidth = paintData.percentTextWidth;

    for (var i = 0; i < percents.length; i++) {
      final text = paintData.getParagraph(
        paintData.addText(percents[i]),
        percentTextWidth[i],
      );
      final startPoint = Offset(
        column - text.width,
        (size.height - row * (i + 1)) - text.height / 2,
      );
      canvas.drawParagraph(text, startPoint);
    }

    for (var i = 0; i < percents.length; i++) {
      canvas.drawLine(
        Offset(column, size.height - row * (i + 1)),
        Offset(size.width, size.height - row * (i + 1)),
        line,
      );
    }
  }

  void drawDiagramPicks(
    double column,
    double weekColumn,
    ui.Size size,
    double row,
    ui.Paint diagramLine,
    AnimatedWeekProgressDiagrammData paintData,
    ui.Canvas canvas,
  ) {
    final x = column + weekColumn - 4;

    final startY = size.height - row;

    const rect = Rect.fromLTRB(0, 0, 180, 140);

    diagramLine.shader = paintData.gradient.createShader(rect);

    for (var i = 0; i < progressInWeek.length; i++) {
      drawDiagramLine(
        canvas,
        Offset(x + weekColumn * i, startY),
        Offset(
          x + weekColumn * i,
          calculatePercentage(progressInWeek[i] * 100),
        ),
        diagramLine,
      );
    }
  }

  void drawWeekDays(
    AnimatedWeekProgressDiagrammData paintData,
    ui.Canvas canvas,
    double weekColumn,
  ) {
    final shortWeekdays = paintData.getShortWeekdays();

    for (var i = 0; i < shortWeekdays.length; i++) {
      final day = paintData.getParagraph(
        paintData.addText(shortWeekdays[i]),
        20,
      );
      canvas.drawParagraph(day, Offset(0, weekColumn * -(i + 1)));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_v2/theme/theme.dart';

class AnimatedWeekProgressDiagrammData {
  final textStyle = ui.TextStyle(color: greyColor, fontSize: 10, height: 1);

  List<String> getShortWeekdays() {
    final dateFormat = DateFormat('EEE');

    final shortWeekdays = List.generate(7, (index) {
      final date = DateTime.utc(
        2024,
      ).add(Duration(days: index));
      return dateFormat.format(date);
    });

    return shortWeekdays.reversed.toList();
  }

  Gradient gradient = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      innerGlowColor,
      primaryColorWithOpacity,
      primaryColor,
    ],
    stops: [0.2, 0.6, 1],
  );

  List<String> percents = ['0%', '25%', '50%', '75%', '100%'];

  List<double> percentTextWidth = List<double>.generate(
    5,
    (int pos) => pos == 0
        ? 15
        : pos != 4
            ? 20
            : 25,
  );

  ui.ParagraphBuilder createParagraphBuilder(
    ui.TextStyle textStyle,
    double fontSize,
  ) {
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.right,
      ),
    )..pushStyle(textStyle);

    return paragraphBuilder;
  }

  ui.Paragraph getParagraph(
    ui.ParagraphBuilder paragraphBuilder,
    double constraintWidth,
  ) {
    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: constraintWidth));

    return paragraph;
  }

  ui.ParagraphBuilder addText(String text) {
    final builder = createParagraphBuilder(
      textStyle,
      10,
    )..addText(text);
    return builder;
  }
}

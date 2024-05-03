import 'dart:math';
import 'package:animations_package/animations_package.dart';
import 'package:animations_package/src/timeline/data_type.dart';
import 'package:flutter/material.dart';

class TimelinePainter extends CustomPainter {
  final DateTime startDate;
  final DateTime endDate;
  final DataCard dataCard;
  TimeLineConfig? timeLineConfig;

  TimelinePainter({
    required this.startDate,
    required this.endDate,
    required this.dataCard,
    this.timeLineConfig,
  }) {
    if (timeLineConfig == null) {
      timeLineConfig = TimeLineConfig();
    } else {
      timeLineConfig = timeLineConfig;
    }
    monthStyle = timeLineConfig!.monthStyle;
    yaerBGTextStyle = timeLineConfig!.yearBGTextStyle;
    border = Paint()
      ..color = timeLineConfig!.borderColor
      ..strokeWidth = timeLineConfig!.borderWidth
      ..style = PaintingStyle.stroke;
    newYearBg1 = Paint()
      ..color = timeLineConfig!.newYearBg1
      ..style = PaintingStyle.fill;
    newYearBg2 = Paint()
      ..color = timeLineConfig!.newYearBg2
      ..style = PaintingStyle.fill;
    title1Style = timeLineConfig!.title1Style;
    title2Style = timeLineConfig!.title2Style;
  }

  late final TextStyle monthStyle;
  late final TextStyle yaerBGTextStyle;
  late final Paint newYearBg1;
  late final Paint newYearBg2;
  late final Paint border;
  late final TextStyle title1Style;
  late final TextStyle title2Style;

  final monthNames = [
    'JAN',
    'FEV',
    'MAR',
    'ABR',
    'MAI',
    'JUN',
    'JUL',
    'AGO',
    'SET',
    'OUT',
    'NOV',
    'DEZ'
  ];

  final outterBorder = Paint()
    ..color = Colors.grey.shade400
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

  final rectPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final blockW = size.width / timeLineConfig!.monthRatio;
    final daysInMonth = DateTime(startDate.year, startDate.month + 1, 0).day;
    final fraction = startDate.day.toDouble() / daysInMonth.toDouble();
    var xStart = -fraction * blockW;
    final cardHeight = (size.height / 2) - 80;

    drawBackgroundShading(canvas, blockW, size, xStart);
    drawYearOnBackground(canvas, blockW, (size.height / 2) - 50, xStart);
    drawMonth(canvas, size, blockW, xStart);
    drawCard(canvas, size, cardHeight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawBackgroundShading(
      Canvas canvas, double blockW, Size size, double xStart) {
    var year = startDate.year;
    var month = startDate.month;
    final mm1 = (1 - month) * blockW + xStart;
    final mm2 = (1 - month + 12) * blockW + xStart;

    var rect = Rect.fromLTRB(mm1, 0, mm2, size.height);
    var bg = (year.isEven) ? newYearBg1 : newYearBg2;
    canvas.drawRect(rect, bg);

    rect = Rect.fromLTRB(mm2, 0, size.width, size.height);
    bg = ((year + 1).isEven) ? newYearBg1 : newYearBg2;
    canvas.drawRect(rect, bg);
  }

  void drawYearOnBackground(
      Canvas canvas, double blockW, double d, double xStart) {
    var year = startDate.year;
    var month = startDate.month;
    final mm1 = (1 - month) * blockW + xStart;
    final mm2 = (1 - month + 12) * blockW + xStart;
    drawText(canvas, Offset(mm1, d - 100), year.toString(), yaerBGTextStyle);
    drawText(
        canvas, Offset(mm2, d - 100), (year + 1).toString(), yaerBGTextStyle);
  }

  void drawMonth(Canvas canvas, Size size, double blockW, double xStart) {
    var pos = Offset(0, size.height);
    var year = startDate.year;
    var month = startDate.month;
    var day = startDate.day;

    const padding = Offset(5, -10);
    const H = 100.0;

    var d = DateTime.utc(startDate.year, startDate.month, 1);
    var m = 0;
    //drawMonths
    while (d.isBefore(endDate)) {
      //draw month name
      drawTextVertical(canvas, pos + padding + Offset(xStart, 0),
          monthNames[month - 1], monthStyle);

      //draw verical line
      final p1 = Offset(m * blockW + xStart, size.height);
      final p2 = Offset(m * blockW + xStart, size.height - H);
      canvas.drawLine(p1, p2, border);
      m++;

      // advance to the next month
      if (month == 12) {
        year++;
        month = 1;
      } else {
        month++;
      }

      pos += Offset(blockW, 0);
      d = DateTime.utc(year, month, 1);
    }
  }

  void drawCard(Canvas canvas, Size size, double d) {
    final xPerDay = size.width / 365;
    const pad = 10.0;
    var height = 100.0;

    final bool hasProject =
        dataCard.serie.any((element) => element.type == DataType.project);

    if (hasProject) {
      final projects = dataCard.serie
          .where((element) => element.type == DataType.project)
          .toList();
      _drawCharts(canvas, height, xPerDay, 0.5 * d, pad, projects);

      DateTime? projectStartDate;
      DateTime? projectEndDate;
      (projectStartDate, projectEndDate) = calculateStartAndEndDate(projects);

      final aa = projectStartDate.difference(startDate);
      final xStart = aa.inDays * xPerDay;
      final bb = projectEndDate.difference(startDate);
      final xFinish = bb.inDays * xPerDay;
      final rect = Rect.fromLTWH(
        xStart - pad,
        0.5 * d - pad,
        xFinish - xStart + 2 * pad,
        height + 2 * pad,
      );
      _drawOuterBorder(canvas, rect);
      //title
      const ofs = Offset(5, -40);
      drawText(canvas, rect.topLeft + ofs, timeLineConfig!.project,
          timeLineConfig!.projectsTextStyle);
    }

    // draw charts
    final courses = dataCard.serie
        .where((element) => element.type == DataType.course)
        .toList();
    _drawCharts(canvas, height, xPerDay, d, pad, courses);

    DateTime? courseStartDate;
    DateTime? courseEndDate;

    (courseStartDate, courseEndDate) = calculateStartAndEndDate(courses);

    // draw outer border
    final aa = courseStartDate.difference(startDate);
    final xStart = aa.inDays * xPerDay;
    final bb = courseEndDate.difference(startDate);
    final xFinish = bb.inDays * xPerDay;
    final rect = Rect.fromLTWH(
      xStart - pad,
      d - pad,
      xFinish - xStart + 2 * pad,
      height + 2 * pad,
    );

    // final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    // canvas.drawRRect(rrect, border);
    _drawOuterBorder(canvas, rect);

    // draw Title
    const ofs = Offset(5, -40);
    drawText(canvas, rect.topLeft + ofs, dataCard.name,
        timeLineConfig!.coursesTextStyle);

    //drawMAXOutterBorder
    final maxHeight = dataCard.serie.length * (height + pad) + pad;
    final maxStartDate =
        dataCard.startDate.difference(startDate).inDays * xPerDay;
    final maxEndDate = dataCard.endDate.difference(startDate).inDays * xPerDay;
    final leftPadding = maxStartDate - 4 * pad;
    final topPadding = height - 6 * pad;
    final maxRect = Rect.fromLTWH(
      leftPadding,
      topPadding,
      maxEndDate - maxStartDate + 8 * pad,
      maxHeight + 2 * height,
    );
    _drawOuterBorder(canvas, maxRect, outterBorder: outterBorder);
  }

  (DateTime startDate, DateTime endDate) calculateStartAndEndDate(
      List<DataSeries> series) {
    var startDate;
    var endDate;
    for (final project in series) {
      startDate ??= project.items.first.timestamp;
      endDate ??= project.items.last.timestamp;
      if (project.items.first.timestamp.isBefore(startDate)) {
        startDate = project.items.first.timestamp;
      }
      if (project.items.last.timestamp.isAfter(endDate)) {
        endDate = project.items.last.timestamp;
      }
    }

    return (startDate, endDate);
  }

  void drawTextVertical(
      Canvas canvas, Offset offset, String monthName, TextStyle monthStyle) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.rotate(-90 * pi / 180);
    drawText(canvas, const Offset(0, 0), monthName, monthStyle);
    canvas.restore();
  }

  _drawCharts(Canvas canvas, double height, double xPerDay, double d,
      double pad, List<DataSeries> series) {
    final cardHeight = series.length * (height + pad) + pad;
    // draw charts
    for (var element in series) {
      if (element.plotType == PlotType.line) {
        drawLinePlot(canvas, cardHeight, xPerDay, height, element);
      }
      if (element.plotType == PlotType.timePeriod) {
        final h =
            drawTimePeriod(canvas, cardHeight + pad, xPerDay, height, element);
        height += (h + pad);
      }
    }
  }

  _drawOuterBorder(Canvas canvas, Rect rect, {Paint? outterBorder}) {
    // draw outer border
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(
      rrect,
      outterBorder ?? border,
    );
  }

  void drawText(
      Canvas canvas, Offset offset, String monthName, TextStyle monthStyle) {
    final tp = measureText(monthName, monthStyle);
    paintText(canvas, offset, tp);
  }

  TextPainter measureText(String monthName, TextStyle monthStyle) {
    final ts = TextSpan(text: monthName, style: monthStyle);
    final tp = TextPainter(
      text: ts,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout(minWidth: 0, maxWidth: double.infinity);
    return tp;
  }

  void paintText(Canvas canvas, Offset offset, TextPainter tp) {
    tp.paint(canvas, offset);
  }

  void drawLinePlot(Canvas canvas, yOffset, double xPerDay, double height,
      DataSeries element) {
    if (element.minValue != null && element.maxValue != null) {
      final yRange = element.maxValue! - element.minValue!;
      final yFactor = height / yRange;
      var path = Path();
      bool pathStarted = false;
      for (var di in element.items) {
        if (di.value != null) {
          final aa = di.timestamp.difference(startDate);
          final x = aa.inDays * xPerDay;
          final y = (di.value! - element.minValue!) * yFactor;
          if (!pathStarted) {
            path.moveTo(x, yOffset + height - y);
            pathStarted = true;
          }
          canvas.drawCircle(Offset(x, yOffset + height - y), 3.0, border);
          path.lineTo(x, yOffset + height - y);
        }
      }
      canvas.drawPath(path, border);
    }
  }

  double drawTimePeriod(Canvas canvas, double d, double xPerDay, double height,
      DataSeries element) {
    final x1 =
        element.items[0].timestamp.difference(startDate).inDays * xPerDay;
    final x2 =
        element.items[1].timestamp.difference(startDate).inDays * xPerDay;

    const y1 = 30.0;
    const y2 = 0.0;
    final rect = Rect.fromLTRB(x1, d + height - y1, x2, d + height + y2);
    element.rect = rect;
    final bool isProject = element.type == DataType.project;
    rectPaint.shader = !isProject
        ? timeLineConfig!.serieGradient.createShader(rect)
        : timeLineConfig!.serieSecondaryGradient.createShader(rect);
    canvas.drawRect(rect, rectPaint);
    final tp = measureText(element.name, title2Style);
    final pos = Offset(
      rect.left + rect.width / 2.0 - tp.width / 2.0,
      rect.bottom - rect.height / 2.0 - tp.height / 2.0,
    );
    paintText(canvas, pos, tp);
    return y1;
  }
}

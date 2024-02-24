import 'dart:math';

import 'package:flutter/material.dart';

class OvalPainter extends CustomPainter {
  OvalPainter({required this.theta});
  final double theta;
  final maxAngle = 720.0;
  final step = 30.0;
  final bgPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, bgPaint);
    final center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;
    for (double angle = 0.0; angle < maxAngle; angle += step) {
      drawCircle(canvas, center, radius, angle, theta);
      radius = radius * 0.8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawCircle(
      Canvas canvas, Offset center, double radius, double angle, double theta) {
    final paint = Paint()
      // ..color = const Color(0xff4CC5F5)
      ..color = Colors.amber.shade600
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
    final diameter = radius * 2;
    final rect = Rect.fromCenter(
        center: Offset.zero, width: diameter * 0.8, height: diameter * 0.9);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle * pi / 180.0 + theta);
    canvas.drawOval(rect, bgPaint);
    canvas.restore();
  }
}

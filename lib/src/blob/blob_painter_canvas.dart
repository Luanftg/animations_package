import 'dart:math';
import 'package:animations_package/src/blob/controller.dart';
import 'package:animations_package/src/blob/particle.dart';
import 'package:flutter/material.dart';

class BlobPainterCanvas extends CustomPainter {
  BlobPainterCanvas({required this.particles});
  final List<Particle> particles;
  Random rnd = Controller.rnd;

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      var paint = Paint();
      paint.color = p.color;
      paint.blendMode = BlendMode.hardLight;
      canvas.drawCircle(p.position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

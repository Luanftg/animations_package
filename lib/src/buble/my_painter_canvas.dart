import 'dart:math';

import 'package:animations_package/src/blob/controller.dart';
import 'package:animations_package/src/blob/particle.dart';
import 'package:flutter/material.dart';

class MyPainterCanvas extends CustomPainter {
  MyPainterCanvas({required this.particles});
  final List<Particle> particles;
  Random rnd = Controller.rnd;

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      var velocity =
          Controller.polarToCartesian(particle.speed, particle.theta);
      var dx = particle.position.dx + velocity.dx;
      var dy = particle.position.dy + velocity.dy;
      if (particle.position.dx < 0 || particle.position.dx > size.width) {
        dx = rnd.nextDouble() * size.width;
      }
      if (particle.position.dy < 0 || particle.position.dy > size.height) {
        dy = rnd.nextDouble() * size.height;
      }
      particle.position = Offset(dx, dy);
    }

    for (var p in particles) {
      var paint = Paint();
      paint.color = Colors.amber;
      canvas.drawCircle(p.position, p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

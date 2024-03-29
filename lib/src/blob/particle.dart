import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Color color;
  double speed;
  double theta;
  double radius;
  Offset? origin;
  Particle({
    required this.position,
    required this.color,
    required this.speed,
    required this.theta,
    required this.radius,
    this.origin,
  });
}

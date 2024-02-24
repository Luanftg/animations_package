import 'dart:math';

import 'package:flutter/material.dart';

class Controller {
  static Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  static Color getRandonColor() {
    var a = rnd.nextInt(255);
    var r = rnd.nextInt(255);
    var g = rnd.nextInt(255);
    var b = rnd.nextInt(255);
    return Color.fromARGB(a, r, g, b);
  }

  static double mapRange(
      double value, double min1, double max1, double min2, double max2) {
    double range1 = min1 - max1;
    double range2 = min2 - max2;
    return min2 + range2 * value / range1;
  }

  static Color getColor(double d, double a) {
    const a = 255;
    final r = ((sin(d * pi * 2) * 127.0 + 127.0)).toInt();
    final g = ((cos(d * pi * 2) * 127.0 + 127.0)).toInt();
    final b = rnd.nextInt(255);
    return Color.fromARGB(a, r, g, b);
  }

  static double getSpeed() => rnd.nextDouble() * 0.2;
  static double getTheta() => rnd.nextDouble() * 2 * pi;
  static double getRadius() => rnd.nextDouble() * 6;

  static Offset polarToCartesian(double speed, double theta) =>
      Offset(speed * cos(theta), speed * sin(theta));
}

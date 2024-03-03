import 'package:flutter/material.dart';

class TimeLineConfig {
  TextStyle monthStyle;
  TextStyle yearBGTextStyle;
  Color newYearBg1;
  Color newYearBg2;
  Color borderColor;
  double borderWidth;
  TextStyle title1Style;
  TextStyle title2Style;
  int monthRatio;
  LinearGradient serieGradient;

  TimeLineConfig({
    this.monthStyle = const TextStyle(
        color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
    this.yearBGTextStyle = const TextStyle(
        color: Colors.white10, fontSize: 400, fontWeight: FontWeight.bold),
    this.newYearBg1 = const Color(0xff2e2255),
    this.newYearBg2 = const Color(0xff1d1638),
    this.borderColor = Colors.white,
    this.borderWidth = 0.5,
    this.title1Style = const TextStyle(color: Colors.white54, fontSize: 30),
    this.title2Style = const TextStyle(color: Colors.white38, fontSize: 20),
    this.monthRatio = 12,
    this.serieGradient = const LinearGradient(
      colors: [Color(0xff662397), Color(0xffdc6c62)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.5, 1.0],
    ),
  });
}

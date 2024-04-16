import 'package:flutter/material.dart';

class TimeLineConfig {
  TextStyle monthStyle;
  TextStyle yearBGTextStyle;
  TextStyle projectsTextStyle;
  TextStyle coursesTextStyle;
  String project;
  String course;
  Color newYearBg1;
  Color newYearBg2;
  Color borderColor;
  Color outterBorderColor;
  double borderWidth;
  double outterBorderWidth;
  TextStyle title1Style;
  TextStyle title2Style;
  int monthRatio;
  LinearGradient serieGradient;
  LinearGradient serieSecondaryGradient;

  TimeLineConfig({
    this.project = 'Projetos',
    this.course = 'Formação',
    this.projectsTextStyle = const TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    this.coursesTextStyle = const TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    this.monthStyle = const TextStyle(
        color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
    this.yearBGTextStyle = const TextStyle(
        color: Colors.white10, fontSize: 400, fontWeight: FontWeight.bold),
    this.newYearBg1 = const Color(0xff2e2255),
    this.newYearBg2 = const Color(0xff1d1638),
    this.borderColor = Colors.white,
    this.borderWidth = 0.5,
    this.title1Style = const TextStyle(color: Colors.white54, fontSize: 30),
    this.title2Style = const TextStyle(color: Colors.white, fontSize: 20),
    this.monthRatio = 12,
    this.serieGradient = const LinearGradient(
      colors: [Color(0xff662397), Color(0xffdc6c62)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.5, 1.0],
    ),
    this.serieSecondaryGradient = const LinearGradient(
      colors: [Color.fromARGB(255, 0, 49, 57), Color(0xff662397)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.5, 1.0],
    ),
    this.outterBorderColor = Colors.grey,
    this.outterBorderWidth = 1.5,
  });
}

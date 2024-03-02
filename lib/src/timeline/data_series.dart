import 'package:animations_package/src/timeline/data_item.dart';
import 'package:animations_package/src/timeline/plot_type.dart';
import 'package:flutter/material.dart';

class DataSeries {
  String name;
  String description;
  List<DataItem> items;
  PlotType plotType;
  double? minValue;
  double? maxValue;
  Rect? rect;

  DataSeries({
    required this.name,
    required this.description,
    required this.items,
    required this.plotType,
    this.minValue = -double.maxFinite,
    this.maxValue = double.maxFinite,
    this.rect,
  });
}

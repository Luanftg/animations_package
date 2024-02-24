import 'package:animations_package/src/timeline/data_item.dart';
import 'package:animations_package/src/timeline/plot_type.dart';

class DataSeries {
  String name;
  String description;
  List<DataItem> items;
  PlotType plotType;
  double? minValue;
  double? maxValue;

  DataSeries({
    required this.name,
    required this.description,
    required this.items,
    required this.plotType,
    this.minValue,
    this.maxValue,
  });
}

import 'package:animations_package/src/timeline/data_series.dart';

class DataCard {
  String name;
  List<DataSeries> serie;
  DateTime startDate;
  DateTime endDate;
  DataCard({
    required this.name,
    required this.serie,
    required this.startDate,
    required this.endDate,
  });
}


import '../../animations_package.dart';

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
  }) {
    DateTime minDate = serie.first.items.first.timestamp;
    DateTime maxDAte = serie.first.items.first.timestamp;

    for (var s in serie) {
      for (var date in s.items) {
        if (date.timestamp.isBefore(minDate)) {
          minDate = date.timestamp;
        }
        if (date.timestamp.isAfter(maxDAte)) {
          maxDAte = date.timestamp;
        }
      }
    }
    startDate = minDate;
    endDate = maxDAte;
  }
}

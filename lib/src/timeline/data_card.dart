import '../../animations_package.dart';

class DataCard {
  String name;
  List<DataSeries> serie;
  late DateTime startDate;
  late DateTime endDate;
  DataCard({
    required this.name,
    required this.serie,
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

import 'package:animations_package/src/timeline/data_card.dart';
import 'package:animations_package/src/timeline/data_item.dart';
import 'package:animations_package/src/timeline/data_series.dart';
import 'package:animations_package/src/timeline/plot_type.dart';
import 'package:animations_package/src/timeline/timeline_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({super.key});

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  var startDate = DateTime.utc(2022, 1, 1);
  var endDate = DateTime.utc(2024, 2, 1);
  late DataCard dataCard;
  late DataSeries dataSeries;

  @override
  void initState() {
    super.initState();
    final d1 = DataItem(
      timestamp: DateTime.utc(2022, 8, 1),
    );
    final d2 = DataItem(
      timestamp: DateTime.utc(2022, 12, 20),
    );
    final d3 = DataItem(
      timestamp: DateTime.utc(2022, 10, 1),
    );
    final d4 = DataItem(
      timestamp: DateTime.utc(2022, 12, 20),
    );

    dataSeries = DataSeries(
      name: 'Flutter',
      description: 'Curso de Formação Flutter - Proz Educação',
      items: <DataItem>[d1, d2],
      plotType: PlotType.timePeriod,
    );
    final dataSeries2 = DataSeries(
      name: 'Código do Futuro',
      description: 'Curso de C#',
      items: <DataItem>[d3, d4],
      plotType: PlotType.timePeriod,
    );

    for (var d in dataSeries.items) {
      dataSeries.minValue =
          d.value ??= 0 < dataSeries.minValue! ? d.value : dataSeries.minValue;
      dataSeries.maxValue =
          d.value ??= 0 > dataSeries.maxValue! ? d.value : dataSeries.maxValue;
    }

    dataCard = DataCard(
      name: 'Formação',
      serie: [dataSeries, dataSeries2],
      startDate: DateTime.utc(2022, 7, 1),
      endDate: DateTime.utc(2022, 12, 1),
    );

    DateTime minDate = dataCard.serie.first.items.first.timestamp;
    DateTime maxDAte = dataCard.serie.first.items.first.timestamp;

    for (var serie in dataCard.serie) {
      for (var date in dataSeries.items) {
        if (date.timestamp.isBefore(minDate)) {
          minDate = date.timestamp;
        }
        if (date.timestamp.isAfter(maxDAte)) {
          maxDAte = date.timestamp;
        }
      }
    }

    dataCard
      ..startDate = minDate
      ..endDate = maxDAte;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      child: GestureDetector(
        onHorizontalDragUpdate: _handleDragUpdate,
        child: CustomPaint(
          painter: TimelinePainter(
            startDate: startDate,
            endDate: endDate,
            dataCard: dataCard,
          ),
          child: Container(),
        ),
      ),
    );
  }

  _handleDragUpdate(DragUpdateDetails details) {
    final dd = details.primaryDelta ?? 1;
    setState(() {
      startDate = startDate.add(Duration(days: -dd.toInt()));
      endDate = endDate.add(Duration(days: -dd.toInt()));
    });
  }

  void onHover(PointerHoverEvent event) {
    bool inside = false;
    for (var serie in dataCard.serie) {
      if (serie.rect != null) {
        inside = serie.rect?.contains(event.localPosition) ?? false;
        if (inside) {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(content: Text('Clicou no ${serie.name}')),
          );
        }
      }
    }
  }
}

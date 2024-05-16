import 'package:flutter/material.dart';
import 'package:animations_package/src/timeline/data_type.dart';
import 'package:animations_package/src/timeline/timeline_widget.dart';
import 'package:animations_package/src/timeline/data_item.dart';
import 'package:animations_package/src/timeline/data_card.dart';
import 'package:animations_package/src/timeline/data_series.dart';
import 'package:animations_package/src/timeline/plot_type.dart';
import 'package:animations_package/src/timeline/timeline_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TimeLineWidget(
        dataCard: dataCard,
        startDate: startDate,
        endDate: endDate,
        timeLineConfig: timeLineConfig,
        onTap: (DataSeries value) => ListTile(
          title: Text(value.name),
          leading: const Icon(Icons.ads_click),
        ),
        // onHover: (value) {},
      ),
    );
  }
}

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
  timestamp: DateTime.utc(2023, 2, 20),
);
final d5 = DataItem(
  timestamp: DateTime.utc(2023, 7, 20),
);
final d6 = DataItem(
  timestamp: DateTime.utc(2024, 4, 20),
);

DataSeries dataSeries = DataSeries(
  name: 'Flutter',
  description: 'Curso de Formação Flutter - Proz Educação',
  items: <DataItem>[d1, d2],
  plotType: PlotType.timePeriod,
  minValue: -double.maxFinite,
  maxValue: double.maxFinite,
);
final dataSeries2 = DataSeries(
  name: 'Código do Futuro',
  description: 'Curso de C#',
  items: <DataItem>[d3, d4],
  plotType: PlotType.timePeriod,
  minValue: -double.maxFinite,
  maxValue: double.maxFinite,
);
final dataSeries3 = DataSeries(
  name: 'MVS-Rastreamento',
  description: 'Aplicativo para Rastreio veícular',
  items: <DataItem>[d5, d6],
  plotType: PlotType.timePeriod,
  minValue: -double.maxFinite,
  maxValue: double.maxFinite,
  type: DataType.project,
);

final DataCard dataCard = DataCard(
  name: 'Formação',
  serie: [dataSeries, dataSeries2, dataSeries3],
);
var startDate = DateTime.utc(2022, 1, 1);
var endDate = DateTime.utc(2024, 2, 1);
TimeLineConfig timeLineConfig = TimeLineConfig()
  ..newYearBg1 = Colors.amber
  ..newYearBg2 = Colors.black
  ..showMaxBorder = false;

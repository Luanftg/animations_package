import 'package:animations_package/animations_package.dart';
import 'package:animations_package/src/timeline/timeline_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({
    super.key,
    required this.dataCard,
    required this.startDate,
    required this.endDate,
    this.timeLineConfig,
  });
  final DataCard dataCard;
  final DateTime startDate;
  final DateTime endDate;
  final TimeLineConfig? timeLineConfig;

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  var startDate = DateTime.utc(2022, 1, 1);
  var endDate = DateTime.utc(2024, 2, 1);

  @override
  void initState() {
    super.initState();
    startDate = startDate;
    endDate = endDate;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      child: GestureDetector(
        onHorizontalDragUpdate: _handleDragUpdate,
        onTapUp: handleOnTapUp,
        child: CustomPaint(
          painter: TimelinePainter(
            startDate: startDate,
            endDate: endDate,
            dataCard: widget.dataCard,
            timeLineConfig: widget.timeLineConfig,
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

  void handleOnTapUp(TapUpDetails details) {
    bool inside = false;
    for (var serie in widget.dataCard.serie) {
      if (serie.rect != null) {
        inside = serie.rect?.contains(details.localPosition) ?? false;
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

  void onHover(PointerHoverEvent event) {
    bool inside = false;
    for (var serie in widget.dataCard.serie) {
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

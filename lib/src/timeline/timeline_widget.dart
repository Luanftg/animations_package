import 'package:animations_package/animations_package.dart';
import 'package:animations_package/src/internal/lib/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({
    super.key,
    required this.dataCard,
    required this.startDate,
    required this.endDate,
    this.timeLineConfig,
    this.onHover,
    this.onTap,
  });

  final DataCard dataCard;
  final DateTime startDate;
  final DateTime endDate;
  final TimeLineConfig? timeLineConfig;
  final Function(PointerHoverEvent event)? onHover;
  final Widget? Function(DataSeries item)? onTap;

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: widget.onHover,
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
    final addDays = startDate.add(Duration(days: -dd.toInt()));

    final endDays = endDate.add(Duration(days: -dd.toInt()));

    if (addDays
            .isBefore(widget.dataCard.endDate.add(const Duration(days: 30))) &&
        endDays
            .isAfter(widget.dataCard.startDate.add(const Duration(days: 30)))) {
      setState(() {
        startDate = startDate.add(Duration(days: -dd.toInt()));
        endDate = endDate.add(Duration(days: -dd.toInt()));
      });
    }
  }

  void handleOnTapUp(TapUpDetails details) {
    bool inside = false;
    for (var serie in widget.dataCard.serie) {
      if (serie.rect != null) {
        inside = serie.rect?.contains(details.localPosition) ?? false;
        if (inside) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                content: widget.onTap?.call(serie) ?? Text(serie.name)),
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
            builder: (context) => AlertDialog(content: Text(serie.name)),
          );
        }
      }
    }
  }
}

import 'package:animations_package/animations_package.dart';
import 'package:animations_package/src/internal/lib/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({
    super.key,
    required this.dataCard,
    required DateTime startDate,
    required DateTime endDate,
    this.timeLineConfig,
    this.onHover,
    this.onTap,
    this.child,
  });

  final DataCard dataCard;
  final TimeLineConfig? timeLineConfig;
  final Function(PointerHoverEvent event)? onHover;
  final Widget? Function(DataSeries item)? onTap;
  final Widget? child;

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = startDate;
    _endDate = endDate;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: widget.onHover,
      child: GestureDetector(
        onHorizontalDragUpdate: _handleDragUpdate,
        onTapUp: handleOnTapUp,
        child: CustomPaint(
          painter: TimelinePainter(
            startDate: _startDate,
            endDate: _endDate,
            dataCard: widget.dataCard,
            timeLineConfig: widget.timeLineConfig,
          ),
          child: widget.child ?? Container(),
        ),
      ),
    );
  }

  _handleDragUpdate(DragUpdateDetails details) {
    final dd = details.primaryDelta ?? 1;
    final addDays = _startDate.add(Duration(days: -dd.toInt()));

    final endDays = _endDate.add(Duration(days: -dd.toInt()));

    if (addDays
            .isBefore(widget.dataCard.endDate.add(const Duration(days: 30))) &&
        endDays
            .isAfter(widget.dataCard.startDate.add(const Duration(days: 30)))) {
      setState(() {
        _startDate = _startDate.add(Duration(days: -dd.toInt()));
        _endDate = _endDate.add(Duration(days: -dd.toInt()));
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

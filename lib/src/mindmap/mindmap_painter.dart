import 'package:animations_package/src/mindmap/node.dart';
import 'package:flutter/material.dart';

class MindMapPainter extends CustomPainter {
  final Node tree;

  MindMapPainter({super.repaint, required this.tree});

  final rectPaint = Paint()..style = PaintingStyle.fill;
  @override
  void paint(Canvas canvas, Size size) {
    drawBackGround(canvas, size);
    drawCells(canvas, size);
  }

  final cellW = 150.0;
  final cellH = 50.0;
  final cellPaintBorder = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;
  final cellPaintFill = Paint()
    ..color = Colors.white54
    ..style = PaintingStyle.fill;

  final textStyle = const TextStyle(fontSize: 20.0, color: Colors.black);
  final padding = 10.0;
  final displacementFactor = 0.75;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawBackGround(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    rectPaint.shader = const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Color(0xff662697), Color(0xffdc6c62)]).createShader(rect);
    canvas.drawRect(rect, rectPaint);
  }

  void drawCells(Canvas canvas, Size size) {
    final center = Offset(padding + cellW / 2, size.height / 2);
    measureCell(tree);
    drawCell(canvas, center, tree);
  }

  Size measureCell(Node? tree) {
    if (tree == null) return const Size(0, 0);
    var subTreeSize = const Size(0, 0);
    for (var element in tree.children) {
      final sz = measureCell(element);
      subTreeSize = Size(subTreeSize.width, subTreeSize.height + sz.height);
    }
    final count = tree.children.length;
    subTreeSize =
        Size(subTreeSize.width, subTreeSize.height + (count - 1) * padding);
    final double heigth =
        subTreeSize.height > cellH ? subTreeSize.height : cellH;
    tree.visualSize = Size(subTreeSize.width, heigth);
    return tree.visualSize!;
  }

  void drawCell(Canvas canvas, Offset center, Node? tree) {
    if (tree == null) return;
    final rect = Rect.fromCenter(center: center, width: cellW, height: cellH);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(rrect, cellPaintFill);
    canvas.drawRRect(rrect, cellPaintBorder);
    tree.centerID = center;
    tree.rect = rect;
    drawTextCentered(canvas, center, tree.value, textStyle, rect.width);

    final totalHeigth = tree.visualSize?.height ?? 0;
    final distance = rect.width * 2 * displacementFactor;
    var pos = Offset(distance, -totalHeigth / 2.0);
    for (var element in tree.children) {
      final sz = element.visualSize;
      final vD = Offset(0, (sz?.height ?? 0) + padding);
      var c = center +
          pos +
          Offset((sz?.width ?? 0) / 2.0, (sz?.height ?? 0) / 2.0);
      canvas.drawLine(center + Offset(rect.width / 2.0, 0),
          c + Offset(-rect.width / 2.0, 0), cellPaintBorder);
      drawCell(canvas, c, element);
      pos += vD;
    }
  }

  void drawTextCentered(Canvas canvas, Offset center, String value,
      TextStyle textStyle, double width) {
    final tp = measureText(value, textStyle, width);
    final pos = center + Offset(-tp.width / 2, -tp.height / 2);
    paintText(canvas, tp, pos);
  }

  TextPainter measureText(String value, TextStyle textStyle, double width) {
    final span = TextSpan(text: value, style: textStyle);
    final tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: width);
    return tp;
  }

  void paintText(Canvas canvas, tp, Offset pos) {
    tp.paint(canvas, pos);
  }
}

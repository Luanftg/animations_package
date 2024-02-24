import 'package:animations_package/src/mindmap/mindmap_painter.dart';
import 'package:animations_package/src/mindmap/node.dart';
import 'package:flutter/material.dart';

class MindMapWidget extends StatefulWidget {
  const MindMapWidget({super.key});

  @override
  State<MindMapWidget> createState() => _MindMapWidgetState();
}

class _MindMapWidgetState extends State<MindMapWidget> {
  FocusNode? _node;
  bool _focused = false;
  final _controller = TextEditingController();
  final _textStyle = const TextStyle(fontSize: 30, color: Colors.black);
  Node tree = Node('Início');
  Node? _selectedNode;

  void _handleFocusChange() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: handleOnTapUp,
            onTap: handleOnTap,
            onDoubleTapDown: handleOnDoubleTapDown,
            onDoubleTap: handleOnDoubleTap,
            onLongPressEnd: handleOnLongPressEnd,
            child: CustomPaint(
                painter: MindMapPainter(tree: tree), child: Container()),
          ),
          const SizedBox(height: 100),
          Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_buildTextField()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleOnTapUp(TapUpDetails details) {
    final n = depthFirstSearch(tree, (node) {
      final inside = node.rect?.contains(details.localPosition);
      return inside ?? false;
    });
    if (n != null) {
      setState(() {
        n.children.add(Node(''));
      });
    }
  }

  void handleOnTap() {}

  void handleOnDoubleTapDown(TapDownDetails details) {
    _selectedNode = depthFirstSearch(tree, (node) {
      final inside = node.rect?.contains(details.localPosition);
      return inside ?? false;
    });
    if (_selectedNode != null) {
      toogleEditMode(_selectedNode?.value ?? '');
    }
  }

  void handleOnDoubleTap() {}

  void handleOnLongPressEnd(LongPressEndDetails details) {}

  Widget _buildTextField() {
    if (_focused) {
      return TextField(
        controller: _controller,
        onSubmitted: handleTextFieldInput,
        focusNode: _node,
        style: _textStyle,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(left: 10, bottom: 8, top: 8),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void toogleEditMode(String value) {
    if (_focused) {
      _node?.unfocus();
    } else {
      _controller.text = value;
      _node?.requestFocus();
    }
    setState(() {
      _focused = !_focused;
    });
  }

  void handleTextFieldInput(String value) {
    if (_selectedNode != null) {
      _selectedNode!.value = value.trim();
      _selectedNode = null;
    }
    toogleEditMode('');
  }
}

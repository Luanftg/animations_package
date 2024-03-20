import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({
    super.key,
    // AnimationController? animationController,
    required this.animatedText,
    this.animatedTextStyle,
    this.duration,
    this.fixedText,
    this.fixedTextStyle,
    this.listener,
    this.statusListener,
    this.textAlign,
    this.curves,
  });

  final void Function(AnimationStatus)? statusListener;
  final void Function()? listener;
  final Duration? duration;
  final String animatedText;
  final String? fixedText;
  final TextStyle? fixedTextStyle;
  final TextStyle? animatedTextStyle;
  final TextAlign? textAlign;
  final Curve? curves;

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 5),
    );
    _animation =
        Tween<double>(begin: 0, end: widget.animatedText.length.toDouble())
            .animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: widget.curves ?? Curves.easeInOut,
      ),
    );

    widget.statusListener;
    widget.listener;
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final int substringIndex = _animation.value.round();
        final displayedText = substringIndex > widget.animatedText.length
            ? widget.animatedText
            : widget.animatedText.substring(0, substringIndex);
        return Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: widget.fixedText ?? '',
                style: widget.fixedTextStyle ??
                    const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text: displayedText,
                style: widget.animatedTextStyle ??
                    const TextStyle(
                      fontFamily: 'Montserrat',
                    ),
              ),
            ],
          ),
          textAlign: widget.textAlign ?? TextAlign.justify,
        );
      },
    );
  }
}

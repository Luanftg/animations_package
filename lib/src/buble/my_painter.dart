import 'package:animations_package/src/buble/custom_animation_controller.dart';
import 'package:animations_package/src/buble/my_painter_canvas.dart';
import 'package:flutter/material.dart';

class BubleWidget extends StatefulWidget {
  const BubleWidget({
    super.key,
    this.backgroundColor,
    this.height,
    this.width,
  });

  final Color? backgroundColor;
  final double? width;
  final double? height;
  @override
  State<BubleWidget> createState() => _BubleWidgetState();
}

class _BubleWidgetState extends State<BubleWidget>
    with SingleTickerProviderStateMixin {
  late CustomAnimationController animationController;
  // late AnimationController animationController;
  // late Animation<double> animation;
  // late List<Particle> particles;

  @override
  void initState() {
    super.initState();

    animationController = CustomAnimationController(
        tickerProvider: this,
        voidCallback: () {
          setState(() {});
        });

    // animationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 10));
    // animation = Tween<double>(begin: 0, end: 300).animate(animationController)
    //   ..addListener(() {
    //     setState(() {});
    //   })
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       animationController.repeat();
    //     } else if (status == AnimationStatus.dismissed) {
    //       animationController.forward();
    //     }
    //   });
    // animationController.forward();
    // particles = List.generate(500, (index) {
    //   var particle = Particle(
    //     color: Controller.getRandonColor(),
    //     speed: Controller.getSpeed(),
    //     theta: Controller.getTheta(),
    //     radius: Controller.getRadius(),
    //     position: const Offset(-1, -1),
    //   );
    //   return particle;
    // });
  }

  @override
  void dispose() {
    // animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width ?? 200,
        height: widget.height ?? 500,
        color: widget.backgroundColor ?? Colors.transparent,
        child: CustomPaint(
          painter: MyPainterCanvas(particles: animationController.particles),
          child: Container(),
        ),
      ),
    );
  }
}

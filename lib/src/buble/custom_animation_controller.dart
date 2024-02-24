import 'package:animations_package/src/blob/controller.dart';
import 'package:animations_package/src/blob/particle.dart';
import 'package:flutter/material.dart';

class CustomAnimationController {
  late AnimationController animationController;
  late Animation<double> animation;
  late List<Particle> _particles;
  List<Particle> get particles => _particles;

  final TickerProvider tickerProvider;
  final VoidCallback? voidCallback;

  CustomAnimationController({required this.tickerProvider, this.voidCallback}) {
    animationController = AnimationController(
        vsync: tickerProvider, duration: const Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController)
      ..addListener(() {
        if (voidCallback != null) {
          voidCallback?.call();
        } else {
          ///TODO: Blob listener
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();
    _particles = List.generate(500, (index) {
      var particle = Particle(
        color: Controller.getRandonColor(),
        speed: Controller.getSpeed(),
        theta: Controller.getTheta(),
        radius: Controller.getRadius(),
        position: const Offset(-1, -1),
      );
      return particle;
    });
  }
}

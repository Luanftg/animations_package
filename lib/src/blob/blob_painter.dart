import 'dart:async';
import 'dart:math';

import 'package:animations_package/src/blob/blob_painter_canvas.dart';
import 'package:animations_package/src/blob/controller.dart';
import 'package:animations_package/src/blob/particle.dart';
import 'package:flutter/material.dart';

class BlobPainter extends StatefulWidget {
  const BlobPainter({super.key});

  @override
  State<BlobPainter> createState() => _BlobPainterState();
}

class _BlobPainterState extends State<BlobPainter>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;
  late List<Particle> particles;
  double t = 0.0;
  double dT = 0.01;
  double radiusFactor = 5;
  int n = 5;
  late double _theta;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _theta = 0.0;
    _timer = Timer.periodic(const Duration(milliseconds: 25), (timer) {
      setState(() {
        _theta += 0.005;
      });
    });
    particles = [];
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 0, end: 100).animate(animationController)
      ..addListener(() {
        if (particles.isEmpty) {
          createBlobField();
        } else {
          setState(() {
            updateBlobField();
          });
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
  }

  void createBlobField() {
    // final size = MediaQuery.sizeOf(context);
    const size = Size(300, 800);
    var dx = size.width / 2;
    var dy = size.height / 2;
    // var center = Offset(dx, dy);
    var center = Offset(MediaQuery.sizeOf(context).width / 2,
        MediaQuery.sizeOf(context).height / 2);
    // var n = 5;
    final radius = size.width / n;
    const a = 0.2;
    blobField(radius, n, a, center);
  }

  void blobField(double radius, int n, double a, Offset center) {
    var theta = 0.0;
    var dTheta = 2 * pi / n;
    if (radius < 10) return;
    particles.add(Particle(
      position: center,
      color: Colors.amber,
      speed: 0,
      theta: theta,
      origin: center,
      radius: radius / 3,
    ));
    for (var i = 0; i < n; i++) {
      var pos = Controller.polarToCartesian(radius, theta) + center;
      particles.add(Particle(
        position: pos,
        color: Controller.getColor(i.toDouble() / n, a),
        speed: 0,
        theta: theta,
        origin: center,
        radius: radius / 3,
      ));

      theta += dTheta;
      var f = 0.5;
      blobField(radius * f, n, a * 1.5, pos);
    }
  }

  void updateBlobField() {
    t += dT;
    radiusFactor = Controller.mapRange(sin(t), -1, 1, 2, 10);
    for (var p in particles) {
      p.position =
          Controller.polarToCartesian(p.radius * radiusFactor, p.theta + t) +
              p.origin!;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black26,
      body:
          // Column(
          //   children: [
          // const SizedBox(height: 24),
          // Slider(
          //   min: 1,
          //   max: 10,
          //   value: n.toDouble(),
          //   onChanged: (value) {
          //     setState(() {
          //       n = value.round().toInt();
          //     });
          //   },
          // ),
          CustomPaint(
        painter: BlobPainterCanvas(particles: particles),
        child: Container(),
      ),
      //   ],
      // ),
    );
  }
}

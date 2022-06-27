import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  const BackgroundPainter();
  final double circleSize = 3;
  final double spacingSize = 9;
  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint()
      ..color = const Color(0xffF0F3F9)
      ..style = PaintingStyle.fill;
    Path path = Path();
    for (int i = 0; i * (spacingSize + circleSize) <= size.width; i++) {
      for (int j = 0; j * (spacingSize + circleSize) <= size.height; j++) {
        path.addOval(Rect.fromCircle(
            center: Offset(
                i * (circleSize + spacingSize), j * (circleSize + spacingSize)),
            radius: circleSize));
      }
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Background extends CustomPaint {
  const Background({Key? key, Widget? child})
      : super(
            key: key,
            painter: const BackgroundPainter(),
            size: Size.infinite,
            child: child);
}

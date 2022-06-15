import 'dart:math';

import 'package:flutter/material.dart';

class MultiColorView extends StatefulWidget {
  final Color? colorPicker;

  const MultiColorView({Key? key, this.colorPicker}) : super(key: key);

  @override
  State<MultiColorView> createState() => _MultiColorViewState();
}

class _MultiColorViewState extends State<MultiColorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: widget.colorPicker ?? Colors.transparent),
      child: widget.colorPicker != null? Container() : CustomPaint(
        painter: GradientArcPainter(),
        child: Container(),
      ),
    );
  }
}

class GradientArcPainter extends CustomPainter {
  final colors = colorList;

  @override
  void paint(Canvas canvas, Size size) {
    final rect =   Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient =   SweepGradient(
      startAngle: 3 * pi / 2,
      endAngle: 7 * pi / 2,
      tileMode: TileMode.repeated,
      colors: colors,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt  // StrokeCap.round is not recommended.
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (1 / 2);
    const startAngle = -pi / 2;
    const sweepAngle = 2 * pi * 1;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


final List<Color> colorList = [

  Colors.blue,
  Colors.purple,
  Colors.pink,
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.cyan,
];

import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  final Widget child;

  const GridBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GridPainter(),
      child: child,
    );
  }
}

class GridPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..color = Colors.white.withOpacity(0.15)
    ..strokeWidth = 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    const double step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), _paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
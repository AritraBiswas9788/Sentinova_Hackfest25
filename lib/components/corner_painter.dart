import 'package:flutter/material.dart';

class CornerBorderPainter extends CustomPainter {
  final double radius = 20;
  final double arcLength = 20;
  final double strokeWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Top Left Corner
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      3.14, // 180°
      1.57, // 90°
      false,
      paint,
    );

    // Top Right Corner
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width - radius, radius), radius: radius),
      -1.57, // -90°
      1.57,
      false,
      paint,
    );

    // Bottom Right Corner
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width - radius, size.height - radius), radius: radius),
      0,
      1.57,
      false,
      paint,
    );

    // Bottom Left Corner
    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, size.height - radius), radius: radius),
      1.57,
      1.57,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
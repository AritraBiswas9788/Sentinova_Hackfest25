import 'package:flutter/material.dart';
import 'dart:math';

class ScribblePainter extends CustomPainter {
  final Color color;

  ScribblePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final random = Random();
    final path = Path();

    // Generate scribbles around the rectangle
    for (int i = 0; i < 5; i++) {
      double startX = random.nextDouble() * size.width;
      double startY = random.nextDouble() * size.height;
      double endX = random.nextDouble() * size.width;
      double endY = random.nextDouble() * size.height;

      path.moveTo(startX, startY);
      path.quadraticBezierTo(
          (startX + endX) / 2, (startY + endY) / 2 + random.nextDouble() * 20,
          endX, endY);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MediaCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final Color primaryColor;

  const MediaCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Custom Paint for Scribble Effect
        CustomPaint(
          painter: ScribblePainter(primaryColor),
          size: Size(160, 200),
        ),

        // Main Card
        Container(
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primaryColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Container
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),

              SizedBox(height: 10),

              // Title
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 5),

              // Notification Count
              Text(
                count,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: MediaCard(
          icon: Icons.facebook,
          title: "Facebook",
          count: "20+",
          primaryColor: Colors.blue,
        ),
      ),
    ),
  ));
}

import 'dart:ui';
import 'package:flutter/material.dart';

class GlowingCard extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color glowColor;
  final List<Color> gradientColors;

  const GlowingCard({
    Key? key,
    required this.text,
    this.width = 70,
    this.height = 120,
    this.glowColor = const Color(0xFF9C27B0),
    this.gradientColors = const [Color(0xFF4B0082), Color(0xFF20002c)],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Outer wrapper with glow
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: glowColor.withOpacity(0.5),
        //     blurRadius: 25,
        //     spreadRadius: 6,
        //     offset: Offset(0, 0),
        //   ),
        // ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Gradient background (without shadow now)
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.3, -0.3),
                  radius: 1.5,
                  colors: gradientColors,
                ),
              ),
            ),

            // Glass blur overlay
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: width,
                height: height,
                color: Colors.white.withOpacity(0.08),
                alignment: Alignment.center,
                // Optional Text
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

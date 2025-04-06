import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IssueButton extends StatefulWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const IssueButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<IssueButton> createState() => _IssueButtonState();
}

class _IssueButtonState extends State<IssueButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _triggerShimmer() {
    _controller.forward(from: 0);
    widget.onTap();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildShimmerOverlay() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.5, 1.0],
              colors: [
                Colors.transparent,
                Colors.red.withOpacity(0.3),
                Colors.transparent,
              ],
              transform: GradientRotation(0.6),
            ).createShader(Rect.fromLTWH(
              _shimmerAnimation.value * bounds.width,
              0,
              bounds.width,
              bounds.height,
            ));
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: _buildButtonCore(),
    );
  }

  Widget _buildButtonCore() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(69, 10, 10, 0.9),
                Color.fromRGBO(0, 0, 0, 0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon,
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerShimmer,
      child: Container(
        width: 150,
        height: 45,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(255, 45, 0, 0.4),
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildShimmerOverlay(),
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/border2.svg',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

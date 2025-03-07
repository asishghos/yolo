//this page's code is I written by gpt

import 'package:flutter/material.dart';

class FrostLinePainter extends CustomPainter {
  final bool visible;
  final bool animate;

  FrostLinePainter({
    required this.visible,
    required this.animate,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!visible && !animate) return;

    final paint = Paint()
      ..color = Colors.red.withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height * 0.3);
    path.lineTo(size.width * 0.2, size.height * 0.35);
    path.lineTo(size.width * 0.5, size.height * 0.25);
    path.lineTo(size.width * 0.8, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.3);

    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(size.width * 0.6, size.height * 0.7);
    path.lineTo(size.width * 0.7, size.height);

    path.moveTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.3, size.height * 0.6);
    path.lineTo(size.width * 0.5, size.height * 0.9);
    path.lineTo(size.width, size.height * 0.7);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

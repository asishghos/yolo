import 'package:flutter/material.dart';
import 'package:yolo/painter/frost_line_painter.dart';

class FrozenCardView extends StatelessWidget {
  const FrozenCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: AspectRatio(
        aspectRatio: 0.63,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueGrey.shade900,
                Colors.blueGrey.shade800,
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              painter: FrostLinePainter(
                visible: true,
                animate: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

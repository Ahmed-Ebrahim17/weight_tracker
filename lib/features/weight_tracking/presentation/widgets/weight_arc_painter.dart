import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weight_tracker/core/theming/colors.dart';

class WeightArcPainter extends CustomPainter {
  final double progress; // 0.0 → 1.0

  const WeightArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Arc goes from ~135° to ~45° (270° sweep), leaving a gap at the bottom
    const startAngle = 135.0 * pi / 180;
    const sweepAngle = 270.0 * pi / 180;

    // Background track
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = const Color(0xFFE8EDF2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round,
    );

    // Foreground progress
    if (progress > 0) {
      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * progress,
        false,
        Paint()
          ..color = ColorsManager.primaryDeepBlue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(WeightArcPainter old) => old.progress != progress;
}

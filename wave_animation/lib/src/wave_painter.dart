// src/wave_painter.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'motion_pattern.dart';

class WavePainter extends CustomPainter {
  final double? animationValue; // 0 -> 1
  final List<Color>? gradientColors1;
  final List<Color>? gradientColors2;
  final int? lineCount;
  final double? amplitude;
  final double? waveLength;
  final WaveMotionPattern? pattern;

  WavePainter({
    this.animationValue,
    this.gradientColors1,
    this.gradientColors2,
    this.pattern,
    this.lineCount,
    this.amplitude,
    this.waveLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final centerY = size.height / 2;

    final _lineCount = lineCount ?? 60;
    final _amplitude = amplitude ?? 28;
    final _waveLength = waveLength ?? 220;
    final _pattern = pattern ?? WaveMotionPattern.flowField;
    final _animationValue = animationValue ?? 0.0;

    final waveCount = (size.width / _waveLength).floor();
    final adjustedWaveLength = size.width / waveCount;

    final loopPhase = _animationValue * 2 * pi;

    // ---------- WAVE LAYER 1 ----------
    for (int i = 0; i < _lineCount; i++) {
      final path = Path();
      final p = i / _lineCount;

      final verticalOffset = (p - 0.5) * size.height * 0.7;
      final localAmplitude = _amplitude * (0.4 + p);
      final basePhase = p * 2 * pi;

      for (double x = 0; x <= size.width; x += 1) {
        double phase;
        double drift;

        final normalizedX = (x / adjustedWaveLength) * 2 * pi;

        switch (_pattern) {
          case WaveMotionPattern.classic:
            phase = loopPhase + basePhase;
            drift = 0;
            break;
          case WaveMotionPattern.flowFieldLoop:
            phase = loopPhase * (0.6 + p) + sin(loopPhase * 0.3 + 2 * pi * p);
            drift = sin(loopPhase * 0.4 + normalizedX) * 8;
            break;
          case WaveMotionPattern.ribbonLoop:
            phase = loopPhase * 0.5 + basePhase;
            drift = cos(loopPhase + p * 6) * 12;
            break;
          case WaveMotionPattern.ribbonDrift:
          case WaveMotionPattern.flowField:
            phase = loopPhase + basePhase;
            drift = 0;
        }

        final y = centerY +
            verticalOffset +
            drift +
            localAmplitude * sin(normalizedX + phase);

        x == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
      }

      paint
        ..strokeWidth = 1.0
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: (gradientColors1 ?? [Colors.blue, Colors.lightBlue])
              .map((c) => c.withOpacity(0.12 + p * 0.35))
              .toList(),
        ).createShader(Offset.zero & size);

      canvas.drawPath(path, paint);
    }

    // ---------- WAVE LAYER 2 ----------
    for (int i = 0; i < _lineCount; i++) {
      final path = Path();
      final p = i / _lineCount;

      final verticalOffset = (p - 0.5) * size.height * 0.7;
      final localAmplitude = _amplitude * (0.3 + p);
      final basePhase = p * 2 * pi;

      for (double x = 0; x <= size.width; x += 1) {
        final normalizedX = (x / adjustedWaveLength) * 2 * pi;

        final phase = -loopPhase * (0.5 + p) + basePhase;
        final drift = cos(loopPhase * 0.3 + normalizedX) * 6;

        final y = centerY +
            verticalOffset +
            drift +
            localAmplitude * sin(normalizedX + phase);

        x == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
      }

      paint
        ..strokeWidth = 1.0
        ..shader = LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: (gradientColors2 ?? [Colors.purple, Colors.pink])
              .map((c) => c.withOpacity(0.10 + p * 0.3))
              .toList(),
        ).createShader(Offset.zero & size);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// src/wave_painter.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'motion_pattern.dart';

/// A custom painter that draws animated wave layers with gradient colors.
///
/// This painter creates multiple wave lines with customizable motion patterns,
/// amplitudes, and colors. It supports two separate wave layers with different
/// gradient colors for a layered visual effect.
class WavePainter extends CustomPainter {
  /// The current animation value between 0.0 and 1.0.
  ///
  /// This value drives the wave motion and should be updated
  /// continuously for smooth animation.
  final double? animationValue;

  /// Gradient colors for the first wave layer.
  ///
  /// Defaults to blue and light blue if not specified.
  final List<Color>? gradientColors1;

  /// Gradient colors for the second wave layer.
  ///
  /// Defaults to purple and pink if not specified.
  final List<Color>? gradientColors2;

  /// Number of wave lines to draw.
  ///
  /// More lines create a denser wave effect. Defaults to 60.
  final int? lineCount;

  /// The amplitude (height) of the waves.
  ///
  /// Higher values create taller waves. Defaults to 28.
  final double? amplitude;

  /// The wavelength (distance between wave peaks).
  ///
  /// Lower values create more compressed waves. Defaults to 220.
  final double? waveLength;

  /// The motion pattern for the wave animation.
  ///
  /// Determines how the waves move and behave over time.
  /// Defaults to [WaveMotionPattern.flowField].
  final WaveMotionPattern? pattern;

  /// Creates a [WavePainter] with optional customization parameters.
  ///
  /// All parameters are optional and will use sensible defaults if not provided.
  WavePainter({
    this.animationValue,
    this.gradientColors1,
    this.gradientColors2,
    this.pattern,
    this.lineCount,
    this.amplitude,
    this.waveLength,
  });

  /// Helper to apply fixed alpha to a list of colors.
  ///
  /// Creates new colors with the specified [alpha] value while preserving
  /// the original RGB values.
  List<Color> _applyAlpha(List<Color> colors, int alpha) {
    return colors
        .map((c) => Color.fromARGB(
              alpha,
              (c.r * 255.0).round().clamp(0, 255),
              (c.g * 255.0).round().clamp(0, 255),
              (c.b * 255.0).round().clamp(0, 255),
            ))
        .toList();
  }

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

    final waveCount = (size.width / _waveLength).floor().clamp(1, 999);
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
          colors: _applyAlpha(
            gradientColors1 ?? [Colors.blue, Colors.lightBlue],
            45, // fixed alpha
          ),
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
          colors: _applyAlpha(
            gradientColors2 ?? [Colors.purple, Colors.pink],
            40, // fixed alpha
          ),
        ).createShader(Offset.zero & size);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// src/wave_widget.dart

import 'package:flutter/material.dart';
import 'wave_painter.dart';
import 'motion_pattern.dart';

class WaveWidget extends StatefulWidget {
  final double? height;
  final List<Color>? gradientColors1;
  final List<Color>? gradientColors2;
  final int? lineCount;
  final double? amplitude;
  final double? waveLength;
  final double? speed;
  final WaveMotionPattern? pattern;
  final bool? visible;

  const WaveWidget({
    super.key,
    this.height,
    this.gradientColors1,
    this.gradientColors2,
    this.lineCount,
    this.amplitude,
    this.waveLength,
    this.speed,
    this.pattern,
    this.visible,
  });

  @override
  State<WaveWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final durationMs = ((4000 ~/ (widget.speed ?? 0.6)).clamp(1, 10000)).toInt();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visible == false) return const SizedBox.shrink();

    return SizedBox(
      height: widget.height ?? 200,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: WavePainter(
              animationValue: _controller.value,
              gradientColors1: widget.gradientColors1,
              gradientColors2: widget.gradientColors2,
              lineCount: widget.lineCount,
              amplitude: widget.amplitude,
              waveLength: widget.waveLength,
              pattern: widget.pattern,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'wave_painter.dart';
import 'motion_pattern.dart';

/// A widget that displays animated waves with customizable colors and motion.
///
/// This widget creates a visually appealing wave animation with dual-layer
/// gradients and multiple motion patterns. Perfect for backgrounds,
/// decorative elements, or loading indicators.
///
/// Example:
/// ```dart
/// WaveWidget(
///   height: 250,
///   gradientColors1: [Colors.blue, Colors.lightBlue],
///   gradientColors2: [Colors.purple, Colors.pink],
///   pattern: WaveMotionPattern.flowFieldLoop,
/// )
/// ```
class WaveWidget extends StatefulWidget {
  /// The height of the wave widget.
  final double height;

  /// Gradient colors for the first wave layer.
  final List<Color> gradientColors1;

  /// Gradient colors for the second wave layer.
  final List<Color> gradientColors2;

  /// Number of wave lines to draw.
  ///
  /// More lines create a denser wave effect. Defaults to 3.
  final int? lineCount;

  /// The amplitude (height) of the waves.
  ///
  /// Higher values create taller waves. Defaults to 20.0.
  final double? amplitude;

  /// The wavelength (distance between wave peaks).
  ///
  /// Lower values create more compressed waves. Defaults to 200.0.
  final double? waveLength;

  /// Animation speed multiplier.
  ///
  /// Higher values make the animation faster. Defaults to 1.0.
  final double? speed;

  /// The motion pattern for the wave animation.
  ///
  /// Determines how the waves move and behave over time.
  /// Defaults to [WaveMotionPattern.classic].
  final WaveMotionPattern? pattern;

  /// Whether the wave animation is visible.
  ///
  /// When false, the widget will not be displayed. Defaults to true.
  final bool? visible;

  /// Creates a [WaveWidget] with the specified parameters.
  ///
  /// The [height], [gradientColors1], and [gradientColors2] parameters are required.
  /// All other parameters are optional and will use sensible defaults.
  const WaveWidget({
    super.key,
    required this.height,
    required this.gradientColors1,
    required this.gradientColors2,
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
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (10000 / (widget.speed ?? 1.0)).round(),
      ),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.visible == false) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
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
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

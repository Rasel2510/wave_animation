/// A customizable wave animation widget for Flutter.
///
/// This library provides a beautiful wave animation widget with multiple
/// layers, gradient colors, and various motion patterns.
///
/// Example usage:
/// ```dart
/// import 'package:wave_animation/wave_animation.dart';
///
/// WaveWidget(
///   height: 250,
///   gradientColors1: [Colors.blue, Colors.lightBlue],
///   gradientColors2: [Colors.purple, Colors.pink],
///   pattern: WaveMotionPattern.flowFieldLoop,
/// )
/// ```
library wave_animation;

export 'src/wave_widget.dart';
export 'src/wave_painter.dart';
export 'src/motion_pattern.dart';

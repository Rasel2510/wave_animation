# Wave Animation

A customizable wave animation widget for Flutter.

## Features
- Multiple wave patterns
- Fully null-safe
- Customizable colors, amplitude, speed, height

## Usage

```dart
import 'package:wave_animation/wave_animation.dart';

WaveWidget(
  height: 200,
  gradientColors1: [Colors.blue, Colors.lightBlueAccent],
  gradientColors2: [Colors.purple, Colors.pinkAccent],
  speed: 0.8,
  pattern: WaveMotionPattern.flowField,
);

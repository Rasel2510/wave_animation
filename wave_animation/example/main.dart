// main.dart
import 'package:flutter/material.dart';
import 'package:wave_animation/wave_animation.dart';

void main() {
  runApp(const WaveExampleApp());
}

class WaveExampleApp extends StatelessWidget {
  const WaveExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wave Animation Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Wave Animation Example')),
        body: Center(
          child: WaveWidget(
            // height of the wave widget
            height: 250,

            // gradient colors for first wave layer
            gradientColors1: [
              Colors.blue.withAlpha(40),
              Colors.lightBlueAccent.withAlpha(40),
            ],

            // gradient colors for second wave layer
            gradientColors2: [
              Colors.purple.withAlpha(50),
              Colors.pinkAccent.withAlpha(50),
            ],

            // number of wave lines to draw
            lineCount: 3,

            // amplitude of the waves
            amplitude: 20,

            // wavelength of the waves
            waveLength: 200,

            // speed multiplier for wave animation
            speed: 0.8,

            // choose motion pattern
            pattern: WaveMotionPattern.flowFieldLoop,

            // visibility toggle
            visible: true,
          ),
        ),
      ),
    );
  }
}

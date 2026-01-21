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
        body:   const Center(
          child: WaveWidget(
            height: 200,
            gradientColors1: [Colors.blue, Colors.lightBlueAccent],
            gradientColors2: [Colors.purple, Colors.pinkAccent],
            speed: 0.8,
            pattern: WaveMotionPattern.flowField,
          ),
        ),
      ),
    );
  }
}

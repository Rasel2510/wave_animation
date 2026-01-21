// test/wave_animation_package_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wave_animation/wave_animation.dart';
 

void main() {
  group('Wave Animation Package Tests', () {
    
    testWidgets('WaveWidget builds with null values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WaveWidget(
              key: Key('waveWidgetNull'),
            ),
          ),
        ),
      );

      // Find the CustomPaint by key inside WaveWidget
      expect(find.byKey(const Key('wavePainter')), findsOneWidget);
    });

    testWidgets('WaveWidget builds with custom parameters', (tester) async {
      await tester.pumpWidget(
          MaterialApp(
          home: Scaffold(
            body: WaveWidget(
              key:  Key('waveWidgetCustom'),
              height: 300,
              lineCount: 40,
              amplitude: 30,
              waveLength: 180,
              speed: 0.8,
              pattern: WaveMotionPattern.flowFieldLoop,
              gradientColors1: [Colors.blue, Colors.lightBlue],
              gradientColors2: [Colors.purple, Colors.pink],
            ),
          ),
        ),
      );

      // Find the CustomPaint by key
      expect(find.byKey(const Key('wavePainter')), findsOneWidget);
    });
  });
}

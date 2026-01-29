// test/wave_animation_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wave_animation/wave_animation.dart';

void main() {
  group('Wave Animation Package Tests', () {
    testWidgets('WaveWidget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WaveWidget(
              height: 250,
              gradientColors1: [Colors.blue, Colors.lightBlue],
              gradientColors2: [Colors.purple, Colors.pink],
            ),
          ),
        ),
      );

      expect(find.byType(WaveWidget), findsOneWidget);
    });

    testWidgets('WaveWidget builds with custom parameters',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WaveWidget(
              height: 300,
              gradientColors1: [Colors.blue, Colors.lightBlue],
              gradientColors2: [Colors.purple, Colors.pink],
              lineCount: 40,
              amplitude: 30,
              waveLength: 180,
              speed: 0.8,
              pattern: WaveMotionPattern.flowFieldLoop,
              visible: true,
            ),
          ),
        ),
      );

      expect(find.byType(WaveWidget), findsOneWidget);
    });

    testWidgets('WaveWidget hides when visible is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WaveWidget(
              height: 250,
              gradientColors1: [Colors.blue, Colors.lightBlue],
              gradientColors2: [Colors.purple, Colors.pink],
              visible: false,
            ),
          ),
        ),
      );

      // Should find SizedBox.shrink() instead of CustomPaint
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(CustomPaint), findsNothing);
    });

    test('WavePainter creates successfully', () {
      final painter = WavePainter(
        animationValue: 0.5,
        gradientColors1: [Colors.blue, Colors.lightBlue],
        gradientColors2: [Colors.purple, Colors.pink],
      );

      expect(painter, isNotNull);
      expect(painter.animationValue, 0.5);
    });

    test('WavePainter with custom parameters', () {
      final painter = WavePainter(
        animationValue: 0.7,
        gradientColors1: [Colors.red, Colors.orange],
        gradientColors2: [Colors.green, Colors.teal],
        lineCount: 50,
        amplitude: 25,
        waveLength: 150,
        pattern: WaveMotionPattern.ribbonLoop,
      );

      expect(painter, isNotNull);
      expect(painter.animationValue, 0.7);
      expect(painter.lineCount, 50);
      expect(painter.amplitude, 25);
      expect(painter.waveLength, 150);
      expect(painter.pattern, WaveMotionPattern.ribbonLoop);
    });

    test('WaveMotionPattern enum has all values', () {
      expect(WaveMotionPattern.values.length, 5);
      expect(WaveMotionPattern.values, contains(WaveMotionPattern.classic));
      expect(WaveMotionPattern.values, contains(WaveMotionPattern.flowField));
      expect(WaveMotionPattern.values, contains(WaveMotionPattern.ribbonDrift));
      expect(
          WaveMotionPattern.values, contains(WaveMotionPattern.flowFieldLoop));
      expect(WaveMotionPattern.values, contains(WaveMotionPattern.ribbonLoop));
    });

    test('WavePainter should repaint', () {
      final painter1 = WavePainter(
        animationValue: 0.5,
        gradientColors1: [Colors.blue, Colors.lightBlue],
        gradientColors2: [Colors.purple, Colors.pink],
      );

      final painter2 = WavePainter(
        animationValue: 0.6,
        gradientColors1: [Colors.blue, Colors.lightBlue],
        gradientColors2: [Colors.purple, Colors.pink],
      );

      expect(painter1.shouldRepaint(painter2), true);
    });
  });
}
